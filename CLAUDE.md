# Term1Fitness: "Road to 100" training tracker

This file gives Claude Code the full context from the original planning conversation on claude.ai. Read it before making changes.

## Who this is for

Victor, a gym beginner (has only benched about 10 times) based in London. Uses an iPhone. Not a developer, so explain changes in plain English, step by step, and tell him how to check the result on his phone.

## Goals (Oct 1 to Dec 31, 2026)

1. **Six-pack / low body fat.** Starting about 83 kg at an estimated 22% body fat. Aesthetic goal: wide shoulders, wide back, slim hips.
2. **100 kg bench press 1 rep max**, tested Monday 28 December 2026. Current 1RM about 70 kg (a grinder).
3. Honest expectation already given to Victor: the six-pack is likely with consistency; 100 kg is possible but unlikely while in a big calorie deficit (85 to 92.5 kg is realistic). Do not promise 100 kg.

## The app

- **Single file: `index.html`.** Plain HTML, CSS and vanilla JavaScript. No framework, no build step, no package.json. Keep it that way unless Victor asks otherwise.
- **Hosting:** GitHub repo `victorofodile1/Term1Fitness`, deployed on Vercel automatically on every push to `main`. Other branches get Vercel preview URLs.
- **Fonts:** Barlow Condensed (headings, numbers) and Barlow (body) from Google Fonts.
- **Design:** day types are colour coded like competition plates: Upper A red, Upper B blue, Lower yellow, Upper C green, rest grey. Light and dark themes via CSS variables on `:root`. Mobile first, max width 560px, bottom tab bar.
- **Tabs:** Today (daily checklist), Plan (13-week calendar), Weights (settings, bench table, exercise start-weight sheet, cloud save sign-in), Weigh-in (bodyweight graph with 7-day average), Food (meals, recipes, prep timeline, shopping list).

### Data and saving

- State lives in one object `S` = `{settings:{oneRM,target,bw}, start:{exerciseId:kg}, days:{"YYYY-MM-DD":{t:{taskKey:true}, log:{exerciseId:kg}, weight}}, theme, updatedAt, syncedUser}`.
- Saved to `localStorage` under key `road100.v1` (always, works offline).
- **Supabase cloud save** syncs the same object as JSON in table `public.progress` (one row per user, `user_id` primary key, row level security so users only see their own row). Schema is in `supabase/schema.sql`.
- Sync rules: on sign in, if this device has never synced with this user, the cloud copy wins; otherwise the newer `updatedAt` wins. Every change pushes to the cloud after 1.5 seconds, and when the page is hidden.
- **Login is username + password, no email.** Supabase needs an email, so the username is converted to `username@term1fitness.app` behind the scenes (`USER_DOMAIN`). No emails are ever sent. "Confirm email" is switched OFF in Supabase. Login form uses `autocomplete="username"` / `current-password` so iPhone Keychain saves it.
- `SUPABASE_URL` and `SUPABASE_ANON_KEY` are set near the top of the script. The key is the publishable (anon) key, which is safe to be public because of row level security. **Never remove or change these two values unless asked. Never add the service_role / secret key anywhere.**
- Supabase project: region West EU (Ireland), free tier.

## Training plan (already built into the app)

- **Schedule (from Mon Oct 5):** Mon Upper A, Tue Lower A, Wed Upper B, Fri Upper C, Sat Lower B. Thu and Sun rest. Starter week unchanged: Thu Oct 1 rest, Fri Oct 2 Lower (old session with goblet squat), Sat Oct 3 Upper C with practice bench 3x8 @ 40 kg (`PLAN0`). Week 13 starts Mon Dec 28.
- **Bench 3 times a week (`BENCH`, Victor's own table).** Mon: warm-ups, heavy single, then 3x3 back-off. Wed: warm-ups then 3x8 volume. Fri: warm-ups then 3x5 paused. Week 1 single 65 kg rising to 92.5 (week 11); week 12 is a benchmark single at 97.5. **1RM test is Mon 28 Dec 2026 (`TEST_KEY`)**: warm-ups to 97.5 x 1, then 100 x 1. No bench Wed 30 Dec. Numbers scale with the 1RM setting (base 70) and test with the target setting (base 100).
- **Exercises (Victor's own plan, same every week, in `PLAN`):** Upper A: chest press, lat pulldown, seated row, incline dumbbell press (replaced pec deck), cable curl, triceps pushdown, cable crunch. Upper B: shoulder press machine, lat pulldown, seated row, dumbbell lateral raise, cable curl, pushdown, crunch. Upper C: lat pulldown, seated row, shoulder press, incline dumbbell press, cable curl, pushdown, crunch (fewer sets). Lower A and B: leg press, barbell Romanian deadlift, leg curl, leg extension, dumbbell calf raise, cable crunch. Fixed reps, no ranges (Victor asked): compounds 10, small lifts 12, lateral raise, calves and crunch 15. Lower A heavier (leg press 4x10, RDL 3x8), Lower B higher reps (leg press 4x12, RDL 3x10). No "reps before failure" wording.
- **Weight progression:** each exercise in `EX` has a December target `T` for a consistent beginner (RDL 90, leg press 120, leg extension 50, cable crunch 80…). Weights climb fast early then taper, never stay the same more than 3 weeks, and always snap to real kit (dumbbells/barbells 2.5 kg, machines 5 kg, RDL jumps 5 kg). Logged weights ("lifted") rebase the rest of the plan.
- **Cardio finisher after every session**, changing weekly (incline treadmill walk, Helix lateral trainer, air bike, skipping, stair master, kettlebell swings, recumbent bike, spin bike, skip and swing circuit, rower, boxing bag, elliptical). No curved treadmill. After leg day it is always an easy incline walk.
- **20,000 steps every day** from Oct 1.
- Gym equipment available: seated row, seated leg curl, leg extension, pec deck, chest press, seated shoulder press, seated lat pull, seated leg press, multi hip, cable stand, lat pulldown, dumbbells, Smith machine, bench press stand, kettlebells, skipping rope, plus the cardio machines above.

## Diet

The old meal plan was removed (2026-10). The daily checklist only has water (from Mon Oct 5), and every Food tab section (daily targets, prep, recipes, shopping list, adjusting) is empty. Victor will fill these in later.

## How to work on this repo

- Make changes in `index.html` only, unless Victor asks for something new.
- After any change, check the page still loads with no console errors and that existing saved data still works (do not rename `road100.v1` or change the shape of `S` without a migration).
- Keep text plain and friendly. Victor reads this on his phone.
- When finished, explain what changed and how Victor can see it (merge the pull request, wait about 30 seconds for Vercel, refresh the app).
