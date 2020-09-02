-- This query extracts dose+durations of norepinephrine administration
-- Total time on the drug can be calculated from this table by grouping using ICUSTAY_ID

-- Get drug administration data from CareVue first

--note by yugang: carevue does not exist in mimiciv so we will delete relevant code
-- now we extract the associated data for metavision patients
With vasomv as
(
  select
    stay_id, linkorderid
    , rate as vaso_rate
    , amount as vaso_amount
    , starttime
    , endtime
  from `physionet-data.mimic_icu.inputevents`
  where itemid = 221906 -- norepinephrine
  and statusdescription != 'Rewritten' -- only valid orders
)
-- now assign this data to every hour of the patient's stay
-- vaso_amount for carevue is not accurate
SELECT stay_id
  , starttime, endtime
  , vaso_rate, vaso_amount
from vasomv
order by stay_id, starttime;
