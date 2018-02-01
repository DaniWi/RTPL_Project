with Ada.Real_Time;
use Ada.Real_Time;

package DetermineTime is

   procedure StartTask;
   function GetTaskTime return Time_Span;

end DetermineTime;
