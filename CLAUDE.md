# Term1Fitness: "Road to 100" training tracker

This file gives Claude Code the full context from the original planning conversation on claude.ai. Read it before making changes.

## Who this is for

Victor, a gym beginner (has only benched about 10 times) based in London. Uses an iPhone. Not a developer, so explain changes in plain English, step by step, and tell him how to check the result on his phone.

## Goals (Oct 1 to Dec 31, 2026)

1. **Six-pack / low body fat.** Starting about 83 kg at an estimated 22% body fat. Aesthetic goal: wide shoulders, wide back, slim hips.
2. **100 kg bench press 1 rep max**, tested Wednesday 30 December 2026. Current 1RM about 70 kg (a grinder).
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
- **Bench 3 times a week.** Mon heavy, Wed volume, Fri paused (moved from Sat when the new plan started). Every week goes up on every day (Victor asked for NO deload weeks). Only exception: Mon Dec 28 is light (3x2 @ 60) because the test is two days later. Bench numbers scale with the 1RM setting (base 70) and test attempts with the target setting (base 100): 92.5, 97.5, 100.
- **Exercises (Victor's own plan, same every week, in `PLAN`):** Upper A: chest press, lat pulldown, seated row, pec deck, cable curl, triceps pushdown, cable crunch. Upper B: shoulder press machine, lat pulldown, seated row, dumbbell lateral raise, cable curl, pushdown, crunch. Upper C: lat pulldown, seated row, shoulder press, pec deck, cable curl, pushdown, crunch (fewer sets). Lower A and B: leg press, barbell Romanian deadlift, leg curl, leg extension, dumbbell calf raise, cable crunch. Rep ranges like 8–12.
- **Weight progression:** each exercise in `EX` has a December target `T` for a consistent beginner (RDL 90, leg press 120, leg extension 50, cable crunch 80…). Weights climb fast early then taper, never stay the same more than 3 weeks, and always snap to real kit (dumbbells/barbells 2.5 kg, machines 5 kg, RDL jumps 5 kg). Logged weights ("lifted") rebase the rest of the plan.
- **Cardio finisher after every session**, changing weekly (incline treadmill walk, Helix lateral trainer, air bike, skipping, stair master, kettlebell swings, recumbent bike, spin bike, skip and swing circuit, rower, boxing bag, elliptical). No curved treadmill. After leg day it is always an easy incline walk.
- **20,000 steps every day** from Oct 1.
- Gym equipment available: seated row, seated leg curl, leg extension, pec deck, chest press, seated shoulder press, seated lat pull, seated leg press, multi hip, cable stand, lat pulldown, dumbbells, Smith machine, bench press stand, kettlebells, skipping rope, plus the cardio machines above.

## Diet (starts Mon Oct 5; steps start Oct 1)

About 1,950 kcal and 173 g protein a day, same food daily, whole foods, no whey. Values were checked against Tesco and Sainsbury's labels.

| Meal | Food | kcal | Protein |
|---|---|---|---|
| Breakfast | 250 g Fage Total 0% Greek yogurt + 30 g granola | 260 | 29 g |
| Lunch: "Chicken and rice" | 200 g raw chicken breast (paprika, garlic powder), half a Tilda microwave jasmine pouch (125 g), 150 g frozen mixed veg, garlic yogurt sauce | 595 | 62 g |
| Snack | Bagel (NYB, 85 g) + 3 slices ham (20 g) + 1 slice cheddar (25 g) | 395 | 28 g |
| Dinner: "Pasta bolognese" | 175 g 5% beef mince, 60 g dry fusilli, passata, tomato purée, ready-chopped onion and carrot, garlic powder, parmesan | 605 | 53 g |
| Fruit | Mixed fruit pot (~200 g) or an apple | 100 | 1 g |

Victor's food preferences: real Greek yogurt (not "Greek style"), microwave jasmine rice, normal fusilli (not spaghetti, not wholewheat), garlic powder instead of fresh garlic, bottled lemon juice, ready-chopped onion and carrots, passata and tomato purée are fine. Meal prep Sunday (4 portions, freeze 1) and Wednesday (3 portions).

Supplements already advised: vitamin D 10 micrograms daily (Oct to Mar), omega-3, optional multivitamin, optional creatine 3 to 5 g.

## How to work on this repo

- Make changes in `index.html` only, unless Victor asks for something new.
- After any change, check the page still loads with no console errors and that existing saved data still works (do not rename `road100.v1` or change the shape of `S` without a migration).
- Keep text plain and friendly. Victor reads this on his phone.
- When finished, explain what changed and how Victor can see it (merge the pull request, wait about 30 seconds for Vercel, refresh the app).
