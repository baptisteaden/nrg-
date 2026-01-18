------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Tables
------------------------------------------------------------------------------------------------------------------------------------------------------------

-- bills
create table public.bills (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz default now(),  
  updated_at timestamptz default now(),
  bill_number text,
  client_name text,
  client_number text,
  account_number text,
  delivery_point_number text,
  address text,
  contract_type text,
  off_peak_hours text,
  power_kva float,
  general_vat_rate float,
  energy_vat_rate float,
  vat_free_cost float,
  vat_cost float,
  overpayment float,
  total_cost float
);

-- bill_periods
create table public.bill_periods (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz default now(),  
  updated_at timestamptz default now(),
  bill_id uuid not null references bills(id),
  start_index_off_peak int,
  end_index_off_peak int,
  start_index_peak int,
  end_index_peak int,
  start_date date,
  end_date date,
  off_peak_rate float,
  peak_rate float,
  season text
);
create index bill_periods_bill_id_idx on public.bill_periods (bill_id);


------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Triggers
------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Create set_updated_at trigger
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Attach trigger - bills
CREATE TRIGGER bills_set_updated_at
BEFORE UPDATE ON public.bills 
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

-- Attach trigger - bill_periods
CREATE TRIGGER bill_periods_set_updated_at
BEFORE UPDATE ON public.bill_periods 
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();
