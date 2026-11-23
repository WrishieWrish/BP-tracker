# Grandpa's BP Tracker

A responsive, single-account blood pressure log. It uses Supabase for authentication and cloud storage, so the same readings are available on phones and laptops after signing in.

## Included
- Email/password sign-in
- Cloud-saved readings: SYS, DIA, pulse, date/time, morning/evening/other, notes
- Cross-device updates through Supabase Realtime
- Average SYS/DIA/pulse, average pulse pressure, estimated MAP, reading count
- BP and pulse trend charts
- Reading history with edit/delete
- CSV export and browser print / Save as PDF
- Light/dark theme

## Free setup

### 1. Create a Supabase project
1. Go to https://supabase.com and create a free account.
2. Create a project. Save the database password somewhere safe.
3. In the project dashboard, open **SQL Editor**.
4. Open `schema.sql` from this folder, paste the complete contents, and run it.

### 2. Configure the webpage
1. In Supabase, open **Project Settings → API** (or **API Keys**).
2. Copy the **Project URL** and the **anon / publishable key**. Never use a `service_role` or secret key in a browser app.
3. Open `index.html` in a text editor.
4. Near the bottom, replace:
   - `YOUR_SUPABASE_URL` with your Project URL
   - `YOUR_SUPABASE_ANON_KEY` with the anon / publishable key
5. Save the file.

### 3. Create the one account
1. Open `index.html` in a browser.
2. Choose **Create account**, enter the email and a strong password.
3. If email confirmation is enabled, confirm the email, then sign in.
4. This is the one account to use on all devices.

For a personal one-account tracker, after account creation go to **Supabase → Authentication → Providers → Email** and turn off public sign-ups if that option is available in your dashboard. Keep email/password sign-in enabled. Do not share the password beyond the people who need to manage the records.

### 4. Publish it free
The easiest static hosting route is GitHub Pages:
1. Create a private or public GitHub repository and upload `index.html`.
2. In repository **Settings → Pages**, choose deploy from the `main` branch and `/ (root)`.
3. Save the published URL and open it on each phone/laptop.
4. Sign in with the same account on each device.

You can also test locally by opening `index.html` after configuring it. For a reliable deployed URL, use HTTPS hosting such as GitHub Pages.

## Important security notes
- The browser contains only the Supabase anon/publishable key. This is expected; Row Level Security in `schema.sql` protects the data.
- Never put a Supabase service-role or secret key in `index.html`, GitHub, or any browser code.
- The SQL policies restrict each signed-in account to its own rows.
- Use a strong password and enable multi-factor authentication on the Supabase account if available.
- If you later want only one specific account to be able to use this, disable public sign-ups after creating it.

## Medical-use notes
This is a record-keeping aid, not a diagnostic system. MAP is estimated as (SYS + 2 × DIA) / 3. Averages are descriptive and do not replace clinical interpretation. Take measurements using the monitor manufacturer's instructions and the clinician's recommended schedule. Do not change medication based on this app.

If a reading is 180 systolic or higher and/or 120 diastolic or higher, repeat after at least one minute. If it remains that high, contact a healthcare professional promptly. If accompanied by chest pain, shortness of breath, weakness, numbness, vision changes, or difficulty speaking, seek emergency medical help.
