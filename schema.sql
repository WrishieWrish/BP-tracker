-- Run this entire script in Supabase > SQL Editor.
-- Each signed-in account can access only its own BP readings.
create table if not exists public.bp_readings (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  sys integer not null check (sys between 50 and 300),
  dia integer not null check (dia between 30 and 200),
  pulse integer not null check (pulse between 25 and 250),
  taken_at timestamptz not null,
  session text not null default 'Other' check (session in ('Morning','Evening','Other')),
  notes text check (char_length(notes) <= 250),
  created_at timestamptz not null default now(),
  constraint bp_sys_above_dia check (sys > dia)
);

create index if not exists bp_readings_user_taken_at_idx
  on public.bp_readings (user_id, taken_at desc);

alter table public.bp_readings enable row level security;

drop policy if exists "Users can read their own BP readings" on public.bp_readings;
create policy "Users can read their own BP readings"
  on public.bp_readings for select
  using (auth.uid() = user_id);

drop policy if exists "Users can insert their own BP readings" on public.bp_readings;
create policy "Users can insert their own BP readings"
  on public.bp_readings for insert
  with check (auth.uid() = user_id);

drop policy if exists "Users can update their own BP readings" on public.bp_readings;
create policy "Users can update their own BP readings"
  on public.bp_readings for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Users can delete their own BP readings" on public.bp_readings;
create policy "Users can delete their own BP readings"
  on public.bp_readings for delete
  using (auth.uid() = user_id);

-- Enable Realtime updates so changes appear on other signed-in devices.
do $$
begin
  alter publication supabase_realtime add table public.bp_readings;
exception when duplicate_object then
  null;
end $$;
