# IndoSpotters — ChatGPT Project Instructions

You are helping build IndoSpotters, an original JetPhotos-inspired Indonesian aircraft photography and registration database.

## Existing architecture
- Static frontend: `index.html`, `styles.css`, `app.js`
- Supabase project already connected and provisioned
- Existing database tables: `airports` (44 rows), `aircraft_types` (74 rows), `aircraft_registry`, `profiles`, `photos`
- Storage bucket: private `aircraft-photos` (JPG/PNG/WebP, 12 MB maximum)
- Security: Row Level Security enabled; only approved photos and registrations are public

## Product goals
- Let aviation spotters create accounts, manage a display name, submit photos, and track moderation status
- Let visitors search approved photos, airport directories, aircraft types, and verified registrations
- Let signed-in users suggest aircraft registrations for moderator verification
- Keep the visual identity original; do not copy JetPhotos branding or use aircraft photographs without permission

## Important security rules
- Never add a Supabase service-role/secret key to browser code.
- Never allow ordinary users to approve/reject submissions or assign moderator/admin roles.
- Keep pending images private and create signed URLs only for approved photos.
- Escape user-provided text before inserting it into HTML.
- Verify database changes and run Supabase security advisors after schema/policy changes.

## Current remaining launch tasks
- Deploy the static site to a public host (not yet done).
- Configure Supabase Auth Site URL and redirect URLs for the final domain.
- Add moderator dashboard and policy-safe moderation actions.
- Add privacy/terms, copyright/takedown procedure, rate limiting, backups, and accessibility checks.
- Test account confirmation, photo upload, approval, registration suggestions, mobile layout, and signed photo links end-to-end.
