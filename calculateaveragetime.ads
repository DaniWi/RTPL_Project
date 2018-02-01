with Ada.Real_Time;
use Ada.Real_Time;

package CalculateAverageTime
with SPARK_Mode
is


   type Time_Array is array (Positive range 1 .. 10) of Time_Span;

   function CalcAverage (times : Time_Array) return Duration
     with
     Pre => (for all i in Time_Array'Range => times (i) > Time_Span_Zero),
     Post => (CalcAverage'Result > Duration'First);

end CalculateAverageTime;
