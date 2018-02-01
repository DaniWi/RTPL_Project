package body DetermineTime is

   Start_Time : Ada.Real_Time.Time := Clock;

   ---------------
   -- StartTask --
   ---------------

   procedure StartTask is
   begin
      Start_Time := Clock;
   end StartTask;

   -----------------
   -- GetTaskTime --
   -----------------

   function GetTaskTime return Time_Span is
   begin
      return Clock - Start_Time;
   end GetTaskTime;

end DetermineTime;
