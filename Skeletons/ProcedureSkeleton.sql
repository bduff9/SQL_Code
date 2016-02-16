-- Procedure
create procedure DICT.PROCNAME(inout PARM type)
comment 'What this procedure is or does'
language sql
[not] deterministic
contains sql|no sql|reads sql data|modifies sql data
PROC_NAME: begin
  -- Variable declaration
  -- Actions occur
  -- Nested body, if needed (such as for cursor using variable)
end PROC_NAME
