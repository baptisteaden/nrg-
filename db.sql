-- Create bills table
create table public.bills (
  id uuid default gen_random_uuid(),
  created_at timestamptz default now(),  
  updated_at timestamptz default now(),
  bill_number integer,
  start_index integer,
  end_index integer,
  start_date date,
  end_date date,
  peak_rate float,
  off_peak_rate float,
  season text,
  contract_type text,
  tax_free_cost float,
  total_cost float,
  energy_cost float,
  tax_cost float,
  vat_cost float,
  address text,
  client_number text,
  client_name text,
  account_number text
);

-- Create set_updated_at trigger
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Attach trigger
CREATE TRIGGER bills_set_updated_at
BEFORE UPDATE ON public.bills 
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

