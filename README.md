# Kenyon Warehouse Management — Demo

Standalone, single-file demonstration of the Warehouse Management module for
Kenyon Emergency Services (a TrustFlight company).

**Everything lives in `index.html`** — no build step, no backend. Open the file
in a browser, or deploy as a static site (Vercel serves it as-is).

## What it shows

- **Stock register** — 674 line items sampled from the 2026 Operations Property
  Book across two warehouses (Bracknell UK, Houston US)
- **Valuation** — live per-warehouse + consolidated value, snapshot history,
  valuation & expiry CSV exports for finance
- **Pick lists** — activation requirement templates (small / medium / large),
  generation engine that allocates nearest-expiry stock first, issue flow that
  deducts stock and writes the audit trail
- **Scan & Action** — barcode lookup with charge out / replenish / inspect
- **Expiry monitoring** — red/amber/green banding and inspection reminders
- **Movements** — append-only audit log of every stock action
- **User roles** — Administrator vs Warehouse staff permissions

All data is illustrative and persists only in the viewer's browser
(localStorage). "Reset demo data" (Administrator role) restores the seed.

`serve.ps1` is a tiny local preview server used during development — it is not
needed to run or deploy the demo.
