# IndoSpotters — starter website

A JetPhotos-inspired starter for an Indonesia-only aircraft photography archive.

## Included
- Responsive aviation-photo website design
- Search by registration, airline, aircraft type, and airport
- Airport directory seeded with 44 Indonesian airport records (community directory, not a certified aviation source)
- Supabase email/password authentication and photographer profiles
- Photo upload form (JPG/PNG/WebP, max 12 MB)
- Pending / approved / rejected photo workflow
- Photographer credit, profile settings, and personal submission tracking
- Aircraft type catalog with 74 types across commercial, regional, cargo, business, general aviation, military, and helicopter categories
- Community aircraft registration suggestions with approval before public visibility
- Public gallery only shows approved submissions
- SQL schema and basic Row Level Security policies

## Important status
This is a functional starter connected to the IndoSpotters Supabase project. The airport directory and authentication/upload flows use the live backend. Sample photo cards are illustrative demo records only when the app is unconfigured; they are not verified sightings. The site is not yet deployed to a public host.

## Step 1 — Create the database and storage
1. The Supabase project is already created and configured for IndoSpotters.
2. Migrations have been applied to the connected project. They create `airports`, `profiles`, `photos`, `aircraft_types`, and `aircraft_registry`, enable RLS, seed 44 airports and 74 aircraft types, create the private `aircraft-photos` bucket, create profiles automatically at signup, and restrict the profile trigger from direct API execution.
3. The website has been configured with the project URL and publishable key. A publishable key is intended for browser use when RLS policies protect data. Never use a `service_role` or secret key in the website/browser.

## Step 2 — Connect the site
The `app.js` file is already configured for this Supabase project, with account registration/sign-in, display-name editing, submission tracking, an aircraft type browser, and registration suggestions. Approved gallery images use short-lived signed URLs from a private bucket so pending uploads are not exposed by permanent public image URLs.

## Step 3 — Run it locally
For the simplest preview, open `index.html` in a browser. If your browser blocks some features on `file://`, use a local static server or publish it using the options below. The Supabase connection is live, but the site is not yet publicly hosted.

## Step 4 — Publish it online
Beginner-friendly options:
- **Netlify**: create an account, drag the project folder into the manual deploy area, or connect a GitHub repository.
- **Cloudflare Pages**: upload/connect the static project.
- **GitHub Pages**: publish the static files from a repository.

For an actual public release, configure Supabase Auth's allowed redirect URLs and site URL to match your hosted website. The Supabase database is configured, but the static website has not been deployed to Netlify, Cloudflare Pages, or another public host yet.

## Step 5 — Review photo submissions
The starter deliberately keeps new uploads in `pending` status. To approve one:
1. Open Supabase Dashboard → Table Editor → `photos`.
2. Find the submission and verify the photographer's rights and aircraft metadata.
3. Change `status` to `approved`. Set `rejected` if it should not be published.
4. Approved photos appear in the public gallery.

For a larger site, build a proper moderator dashboard using server-side authorization / trusted admin actions. Do not let ordinary users update status or assign themselves an admin role.

## Data model
- `airports`: ICAO code, airport name, city, region, country (44 initial entries; add verified airports as needed)
- `profiles`: photographer display name and role (role assignment must be controlled by an administrator)
- `photos`: registration, airline, aircraft type, airport, photo date, livery, caption, photographer credit, storage path, status, moderation note
- `aircraft_types`: aircraft type code, manufacturer, model, and category (74 initial entries)
- `aircraft_registry`: suggested registration, operator, type, serial number, notes, submitter, and moderation status

## ChatGPT Project
Create a ChatGPT Project named **IndoSpotters** and paste the contents of `CHATGPT_PROJECT_INSTRUCTIONS.md` into its project instructions. Add this project ZIP as a project file so future conversations can continue with the same architecture and safety rules. The ChatGPT Project itself must be created in the ChatGPT interface; this package does not create that UI object automatically.

## Before launch
- Add terms of service, privacy policy, copyright/takedown process, and community photo rules.
- Verify every registration and airport code; the starter seed list is not an exhaustive official directory.
- Use a moderator workflow and anti-spam/rate limiting before inviting the public.
- Consider image resizing, thumbnails, EXIF privacy checks, duplicate detection, and backups.
- Make clear that photographers retain copyright and grant your site only the display licence they agree to.
- Do not publish restricted or sensitive location details, especially for military or security-sensitive locations.
- Add accessibility, SEO, analytics consent, and error monitoring.
- Check applicable Indonesian privacy and copyright laws before public launch.

## JetPhotos-inspired, not a copy
This is an original starter design inspired by common aviation-database patterns. Choose your final name, logo, colors, terms, and content; do not copy JetPhotos' logo, branding, code, or photos.
