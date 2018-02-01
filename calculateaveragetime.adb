package body CalculateAverageTime
with SPARK_Mode
is

   -----------------
   -- CalcAverage --
   -----------------

   function CalcAverage(times : Time_Array) return Duration is
      times_sum_old : Time_Span := Time_Span_Zero;
      times_sum_new : Time_Span;
      time_average : Time_Span;

     begin
      for i in Time_Array'Range loop

         times_sum_new := times_sum_old + times(i);
         pragma Assert (times_sum_new > times_sum_old);
         times_sum_old := times_sum_new;

      end loop;
      time_average := times_sum_new / 2;
      return To_Duration(time_average);
   end CalcAverage;

end CalculateAverageTime;
