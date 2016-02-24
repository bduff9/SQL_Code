create or replace function DUFFEY.GETEPID(inout USHOWID numeric(6,0), inout DAIRED char(13), inout EID numeric(6,0)) as $$
declare
  SID numeric(6,0);
  X integer;
  EIDTEMP numeric(6,0);
begin
  select SHOWID into SID from DUFFEY.USERSHOWS where USERSHOWID = USHOWID;
  raise notice 'Show ID is %', SID;
  select count(*) into X from DUFFEY.EPISODES where SHOWID = SID and DATEAIRED = to_date(DAIRED, 'YYYY-MM-DD');
  raise notice 'Count of existing episodes is %', X;
  if X < 1 then
    select EPISODEID into EIDTEMP from DUFFEY.EPISODES order by EPISODEID desc limit 1;
    EID := EIDTEMP + 1;
    raise notice 'Highest episode id was %1 and this episode id will be %2', EIDTEMP, EID;
    insert into DUFFEY.EPISODES (EPISODEID, SHOWID, DATEAIRED) values (EID, SID, to_date(DAIRED, 'YYYY-MM-DD'));
  else
    select EPISODEID into EID from DUFFEY.EPISODES where SHOWID = SID and DATEAIRED = to_date(DAIRED, 'YYYY-MM-DD');
  end if;
end;
$$ language plpgsql;