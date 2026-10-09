-- IndoSpotters catalog expansion migration
-- Already applied to the connected Supabase project on 2026-10-09.
create table if not exists public.aircraft_types (
  type_code text primary key,
  manufacturer text not null,
  model text not null,
  category text not null default 'Commercial',
  created_at timestamptz not null default now()
);
alter table public.aircraft_types enable row level security;
drop policy if exists "Anyone can read aircraft type catalog" on public.aircraft_types;
create policy "Anyone can read aircraft type catalog" on public.aircraft_types for select to anon, authenticated using (true);

create table if not exists public.aircraft_registry (
  registration text primary key check (registration = upper(registration) and char_length(registration) between 3 and 16),
  operator text,
  type_code text references public.aircraft_types(type_code),
  serial_number text,
  notes text,
  status text not null default 'pending' check (status in ('pending','approved','rejected')),
  submitted_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
alter table public.aircraft_registry enable row level security;
drop policy if exists "Public can read approved aircraft registry" on public.aircraft_registry;
create policy "Public can read approved aircraft registry" on public.aircraft_registry for select to anon, authenticated using (status = 'approved' or (select auth.uid()) = submitted_by);
drop policy if exists "Signed in users can suggest aircraft registrations" on public.aircraft_registry;
create policy "Signed in users can suggest aircraft registrations" on public.aircraft_registry for insert to authenticated with check ((select auth.uid()) = submitted_by and status = 'pending');
drop policy if exists "Users can update their own pending registry suggestions" on public.aircraft_registry;
create policy "Users can update their own pending registry suggestions" on public.aircraft_registry for update to authenticated using ((select auth.uid()) = submitted_by and status = 'pending') with check ((select auth.uid()) = submitted_by and status = 'pending');
create index if not exists aircraft_registry_type_idx on public.aircraft_registry(type_code);
create index if not exists aircraft_registry_operator_idx on public.aircraft_registry(operator);
create index if not exists aircraft_registry_status_idx on public.aircraft_registry(status);

insert into public.airports (icao, name, city, region) values
('WAJJ','Sentani International Airport','Jayapura','Papua'),
('WABB','Frans Kaisiepo International Airport','Biak','Papua'),
('WABP','Rendani Airport','Manokwari','West Papua'),
('WASS','Domine Eduard Osok Airport','Sorong','Southwest Papua'),
('WAMT','Sultan Babullah Airport','Ternate','North Maluku'),
('WAPP','Pattimura International Airport','Ambon','Maluku'),
('WATT','El Tari International Airport','Kupang','East Nusa Tenggara'),
('WADL','Lombok International Airport','Praya / Lombok','West Nusa Tenggara'),
('WIMN','Silangit International Airport','Siborong-Borong','North Sumatra'),
('WIPT','Minangkabau International Airport','Padang','West Sumatra'),
('WIPL','Fatmawati Soekarno Airport','Bengkulu','Bengkulu'),
('WICT','Radin Inten II International Airport','Bandar Lampung','Lampung'),
('WIPK','Depati Amir Airport','Pangkalpinang','Bangka Belitung'),
('WIKT','H.A.S. Hanandjoeddin International Airport','Tanjung Pandan','Bangka Belitung'),
('WIOK','Rahadi Oesman Airport','Ketapang','West Kalimantan'),
('WIOG','Tebelian Airport','Sintang','West Kalimantan'),
('WAOO','Syamsudin Noor International Airport','Banjarbaru / Banjarmasin','South Kalimantan'),
('WAOC','Warukin Airport','Tanjung','South Kalimantan'),
('WAGS','Tjilik Riwut Airport','Palangka Raya','Central Kalimantan'),
('WAGG','Iskandar Airport','Pangkalan Bun','Central Kalimantan'),
('WALS','Aji Pangeran Tumenggung Pranoto Airport','Samarinda','East Kalimantan'),
('WALJ','Kalimarau Airport','Tanjung Redeb / Berau','East Kalimantan'),
('WARA','Abdul Rachman Saleh Airport','Malang','East Java'),
('WARI','Iswahyudi Air Force Base','Madiun','East Java'),
('WADY','Banyuwangi International Airport','Banyuwangi','East Java'),
('WICM','Cakrabhuwana Airport','Cirebon','West Java'),
('WICN','Nusawiru Airport','Pangandaran','West Java'),
('WIMB','Binaka Airport','Gunungsitoli / Nias','North Sumatra'),
('WITC','Cut Nyak Dhien Airport','Nagan Raya','Aceh'),
('WITM','Malikus Saleh Airport','Lhokseumawe','Aceh'),
('WITT','Sultan Iskandar Muda International Airport','Banda Aceh','Aceh'),
('WIMT','Lasondre Airport','Pulau-Pulau Batu','North Sumatra')
on conflict (icao) do update set name=excluded.name, city=excluded.city, region=excluded.region;

insert into public.aircraft_types (type_code, manufacturer, model, category) values
('A318','Airbus','A318','Commercial'),('A319','Airbus','A319','Commercial'),('A320','Airbus','A320','Commercial'),('A20N','Airbus','A320neo','Commercial'),('A321','Airbus','A321','Commercial'),('A21N','Airbus','A321neo','Commercial'),('A332','Airbus','A330-200','Commercial'),('A333','Airbus','A330-300','Commercial'),('A339','Airbus','A330-900neo','Commercial'),('A359','Airbus','A350-900','Commercial'),('A35K','Airbus','A350-1000','Commercial'),('A388','Airbus','A380-800','Commercial'),
('B712','Boeing','717-200','Commercial'),('B734','Boeing','737-400','Commercial'),('B735','Boeing','737-500','Commercial'),('B736','Boeing','737-600','Commercial'),('B737','Boeing','737-700','Commercial'),('B738','Boeing','737-800','Commercial'),('B739','Boeing','737-900ER','Commercial'),('B37M','Boeing','737 MAX 7','Commercial'),('B38M','Boeing','737 MAX 8','Commercial'),('B39M','Boeing','737 MAX 9','Commercial'),('B744','Boeing','747-400','Commercial/Cargo'),('B748','Boeing','747-8','Commercial/Cargo'),('B752','Boeing','757-200','Commercial/Cargo'),('B763','Boeing','767-300','Commercial/Cargo'),('B772','Boeing','777-200','Commercial'),('B77W','Boeing','777-300ER','Commercial'),('B788','Boeing','787-8 Dreamliner','Commercial'),('B789','Boeing','787-9 Dreamliner','Commercial'),('B78X','Boeing','787-10 Dreamliner','Commercial'),
('BCS1','Airbus','A220-100','Commercial'),('BCS3','Airbus','A220-300','Commercial'),('E170','Embraer','E170','Commercial'),('E175','Embraer','E175','Commercial'),('E190','Embraer','E190','Commercial'),('E195','Embraer','E195','Commercial'),('E290','Embraer','E190-E2','Commercial'),('E295','Embraer','E195-E2','Commercial'),('AT72','ATR','ATR 72','Regional'),('AT43','ATR','ATR 42','Regional'),('DH8D','De Havilland Canada','Dash 8 Q400','Regional'),('CRJ9','Mitsubishi / Bombardier','CRJ-900','Regional'),('F50','Fokker','Fokker 50','Regional'),('F70','Fokker','Fokker 70','Regional'),('F100','Fokker','Fokker 100','Regional'),
('C208','Cessna','208 Caravan','General aviation'),('C172','Cessna','172 Skyhawk','General aviation'),('PC12','Pilatus','PC-12','General aviation'),('BE20','Beechcraft','King Air 200','General aviation'),('B350','Beechcraft','King Air 350','General aviation'),('CL60','Bombardier','Challenger 600 series','Business jet'),('GLF5','Gulfstream','Gulfstream V','Business jet'),('GLEX','Bombardier','Global Express','Business jet'),('LJ45','Learjet','Learjet 45','Business jet'),('C17','Boeing','C-17 Globemaster III','Military'),('C130','Lockheed Martin','C-130 Hercules','Military/Transport'),('C295','Airbus Defence','C295','Military/Transport'),('CN35','CASA','CN-235','Military/Transport'),('A400','Airbus Defence','A400M Atlas','Military/Transport'),('F16','Lockheed Martin','F-16 Fighting Falcon','Military'),('FA50','KAI','FA-50 Fighting Eagle','Military'),('T50','KAI','T-50 Golden Eagle','Military/Trainer'),('RFL1','Dassault Aviation','Rafale','Military'),('SU30','Sukhoi','Su-30 family','Military'),('H60','Sikorsky','S-70 / H-60 family','Helicopter'),('H145','Airbus Helicopters','H145','Helicopter'),('B412','Bell','412','Helicopter'),('AW139','Leonardo','AW139','Helicopter'),('B77L','Boeing','777 Freighter','Cargo'),('MD11','McDonnell Douglas','MD-11','Cargo'),('AN12','Antonov','An-12','Cargo'),('AN26','Antonov','An-26','Cargo')
on conflict (type_code) do update set manufacturer=excluded.manufacturer, model=excluded.model, category=excluded.category;
