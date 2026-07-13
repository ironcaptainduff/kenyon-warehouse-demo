# Tiny static file server for local preview of the demo (no node/python needed).
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add('http://localhost:8642/')
$listener.Start()
Write-Host "Serving $root at http://localhost:8642/"
while ($listener.IsListening) {
  try {
    $ctx = $listener.GetContext()
    $path = $ctx.Request.Url.AbsolutePath.TrimStart('/')
    if ([string]::IsNullOrEmpty($path)) { $path = 'index.html' }
    $file = Join-Path $root $path
    if (Test-Path $file -PathType Leaf) {
      $bytes = [IO.File]::ReadAllBytes($file)
      $ctx.Response.ContentType = if ($file -match '\.html$') { 'text/html; charset=utf-8' } elseif ($file -match '\.json$') { 'application/json' } elseif ($file -match '\.png$') { 'image/png' } else { 'application/octet-stream' }
      $ctx.Response.ContentLength64 = $bytes.Length
      # HEAD requests must not get a body (writing one corrupts the connection)
      if ($ctx.Request.HttpMethod -ne 'HEAD') {
        $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
      }
    } else {
      $ctx.Response.StatusCode = 404
    }
    $ctx.Response.Close()
  } catch {
    # never let one bad request kill the server
    try { $ctx.Response.Abort() } catch {}
  }
}
