with vasomv as
(
  select
    stay_id, linkorderid
    , rate as vaso_rate
    , amount as vaso_amount
    , starttime
    , endtime
  from `physionet-data.mimic_icu.inputevents`
  where itemid = 221653 -- dobutamine
  and statusdescription != 'Rewritten' -- only valid orders
)
-- now assign this data to every hour of the patient's stay
-- vaso_amount for carevue is not accurate
SELECT stay_id
  , starttime, endtime
  , vaso_rate, vaso_amount
from vasomv
order by stay_id, starttime;
