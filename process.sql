
-- show background process
select paddr, name, description
from v$bgprocess
order by paddr desc;

-- show current running process
select * 
from v$process
where pname is not null;

select paddr, name, description
from v$bgprocess
where paddr <> '00'
order by paddr desc;