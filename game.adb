with Ada.Numerics.Discrete_Random;
with Ada.Numerics.Float_Random;
use Ada.Numerics;
with Ada.Text_IO;
use Ada.Text_IO;
with UserInterface;
use UserInterface;
with GenericOperation;
use GenericOperation;
with DetermineTime;
use DetermineTime;
with CalculateAverageTime;
use CalculateAverageTime;
with Ada.Real_Time;
use Ada.Real_Time;

package body Game is

   ---------------
   -- startGame --
   ---------------

   procedure startGame is

      subtype Integer_Range is Integer range 1 .. 100;

      package Random_Task is new Ada.Numerics.Discrete_Random (Operation_Type);
      package Generator_Integer is
        new Ada.Numerics.Discrete_Random (Integer_Range);

      Gen_OP_Type : Random_Task.Generator;
      Gen_Integer : aliased Generator_Integer.Generator;
      Gen_Float : aliased Float_Random.Generator;

      type ACCESS_TO_GEN_INT is access all Generator_Integer.Generator;
      type ACCESS_TO_GEN_FLOAT is access all Float_Random.Generator;

      task type Task_Easy (Random_Operation : Operation_Type;
                           Gen_Integer : ACCESS_TO_GEN_INT) is
         entry Start;
      end Task_Easy;
      task type Task_Hard (Random_Operation : Operation_Type;
                           Gen_Float : ACCESS_TO_GEN_FLOAT) is
         entry Start;
      end Task_Hard;
      type task_ptr_easy_type is access Task_Easy;
      type task_ptr_hard_type is access Task_Hard;
      task_ptr_easy : task_ptr_easy_type;
      task_ptr_hard : task_ptr_hard_type;

      times : Time_Array;
      task_number : Positive := 1;
      ---------
      -- ADD --
      ---------

      task body Task_Easy is
         LHS : constant Integer := Generator_Integer.Random (Gen_Integer.all);
         RHS : constant Integer := Generator_Integer.Random (Gen_Integer.all);

         Result : Integer := 0;
         function Easy_Operation is new Operation (Integer);
      begin
         accept Start do
            StartTask;
            Result := Easy_Operation (LHS, RHS, Random_Operation);
            loop
               Print_Equation_Integer (LHS, RHS, Random_Operation);
               exit when Integer'Value (Get_Result) = Result;
               Put_Line ("Wrong Result! Do it again!");
            end loop;
            Put ("Time: ");
            times (task_number) := GetTaskTime;
            Put_Line (Duration'Image (To_Duration (times (task_number))));
            task_number := task_number + 1;
         end Start;
      end Task_Easy;

      ---------
      -- SUB --
      ---------

      task body Task_Hard is
         LHS : Float := Float_Random.Random (Gen_Float.all) * 1000.0;
         RHS : Float := Float_Random.Random (Gen_Float.all) * 1000.0;


         Result : Float := 0.0;
         Start_Time : constant Ada.Real_Time.Time := Clock;
         pragma Unreferenced (Start_Time);
         function Hard_Operation is new Operation (Float);
      begin
         LHS := Float (Integer (LHS)) / 10.0;
         RHS := Float (Integer (RHS)) / 10.0;
         accept Start do
            StartTask;
            Result := Hard_Operation (LHS, RHS, Random_Operation);
            loop
               Print_Equation_Float (LHS, RHS, Random_Operation);
               exit when (abs (Float'Value (Get_Result) - Result)) <= 0.1;
               Put_Line ("Wrong Result! Do it again!");
            end loop;
            Put ("Time: ");
            times (task_number) := GetTaskTime;
            Put_Line (Duration'Image (To_Duration (times (task_number))));
            task_number := task_number + 1;
         end Start;
      end Task_Hard;


      random_op : Operation_Type;
   begin
      Random_Task.Reset (Gen_OP_Type);
      Generator_Integer.Reset (Gen_Integer);
      Float_Random.Reset (Gen_Float);
      --  loop to create 10 random assignments
      for i in Integer range 1 .. 10 loop

         random_op := Random_Task.Random (Gen_OP_Type);
         case User_Protected.Difficulty_Get is
            when 1 =>
               Put_Line ("EASY:");
               task_ptr_easy := new Task_Easy (random_op, Gen_Integer'Access);
               task_ptr_easy.Start;
            when 2 =>
               Put_Line ("HARD:");
               task_ptr_hard := new Task_Hard (random_op, Gen_Float'Access);
               task_ptr_hard.Start;

         end case;
      --  random choose of assignment type and creation of the needed task type

      end loop;
      Put_Line ("");
      Put ("Average Time: ");
      Put_Line (Duration'Image (CalcAverage (times)) & " s");
   end startGame;

end Game;
