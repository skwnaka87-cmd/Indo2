# IndoSpotters — connected aviation photography archive

IndoSpotters is an original, JetPhotos-inspired community site for Indonesian aircraft photography, aircraft types, registration records, and airport directories.

## Preview and run

- Open `preview.html` for a self-contained single-file preview, or `index.html` to inspect the normal source layout.
- If your browser restricts local files, open a terminal in this folder and run `python3 -m http.server 8080`, then visit `http://localhost:8080`.
- The frontend is already configured to use the existing IndoSpotters Supabase project with a browser-safe publishable key. No service-role or secret key is included.

## Connected backend status

The connected Supabase project has already been provisioned. Do **not** run an old starter SQL script against it. The live database currently contains:

- `airports`: 44 Indonesian airport records
- `aircraft_types`: 74 aircraft types, covering commercial, regional, business, general aviation, cargo, military and helicopter categories
- `aircraft_registry`: verified aircraft registration directory and pending community suggestions
- `profiles`: user display names and roles, with automatic profile creation on signup
- `photos`: user-submitted aircraft photos and pending/approved/rejected moderation status
- Private Storage bucket `aircraft-photos`, limited to JPEG, PNG and WebP images up to 12 MB

Migrations applied to the connected project:

1. `indospotters_initial_schema`
2. `indospotters_profile_on_signup`
3. `indospotters_security_tuning`
4. `indospotters_aircraft_catalog_and_airport_expansion`

Row Level Security is enabled. Public visitors can view only approved photos and approved aircraft registrations. Signed-in users can manage their own profile, submit photos, suggest aircraft registrations, and check their submission statuses. New content remains pending until a moderator verifies it.

## Features in this frontend

- Email/password account creation and sign-in
- Profile display-name editing
- Approved photo archive with keyword, airport and sort filters
- Private photo uploads with a 12 MB file-size cap and ownership confirmation
- Personal photo submission status list
- Searchable aircraft type catalogue
- Aircraft registration lookup and verified-registration suggestions
- Airport directory backed by the live database
- Responsive desktop and mobile layout

## Publishing it online

The database is live, but this folder has **not** been deployed to a public website host. To publish it, upload the folder to a static host such as Netlify, Cloudflare Pages, or GitHub Pages. After deployment, set the deployed URL in Supabase Authentication → URL Configuration (Site URL and Redirect URLs). Test sign-up confirmation emails, image upload, signed image URLs, and moderator approval before sharing it publicly.

## Moderation and launch notes

- Approve or reject pending photo records in Supabase Table Editor by changing `photos.status` to `approved` or `rejected` after checking the image, rights, registration, and caption.
- Review `aircraft_registry` suggestions before changing their status to `approved`.
- Do not give ordinary users a way to approve content or assign themselves moderator/admin roles.
- Before public launch, add privacy/terms pages, a copyright and takedown process, rate limiting, backups, and a moderator dashboard. Check Indonesian privacy and copyright requirements.
- Photographers should upload only images they own or have permission to publish. Do not publish sensitive restricted-location details.

## ChatGPT Project handoff

A ChatGPT Project cannot be created by this website/database connection. To keep the work together, create a Project named **IndoSpotters** in ChatGPT and add `CHATGPT_PROJECT_INSTRUCTIONS.md` plus this README as project files.
