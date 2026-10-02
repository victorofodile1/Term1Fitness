-- Term1Fitness / Road to 100: database setup (already run once in Supabase).
-- Kept here for reference. Only re-run on a brand new Supabase project.

create table public.progress (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.progress enable row level security;

create policy "read own" on public.progress
  for select using (auth.uid() = user_id);
create policy "insert own" on public.progress
  for insert with check (auth.uid() = user_id);
create policy "update own" on public.progress
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
