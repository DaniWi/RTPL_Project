with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;

package body UserInterface is

   -----------------
   -- User_Access --
   -----------------

   protected body User_Access is

      --------------
      -- Name_Set --
      --------------

      procedure Name_Set (Name : String) is
      begin
         User.Name := To_Unbounded_String (Name);
      end Name_Set;

      --------------
      -- Name_Get --
      --------------

      function Name_Get return String is
      begin
         return To_String (User.Name);
      end Name_Get;

      --------------------
      -- Difficulty_Set --
      --------------------

      procedure Difficulty_Set (Difficulty : Integer;
                                Check_Input : out Boolean) is
      begin
         if Difficulty = 1 or Difficulty = 2 then
            User.Difficulty := Level'Value (Difficulty'Img);
            Check_Input := True;
         else
            Check_Input := False;
         end if;
      end Difficulty_Set;

      --------------------
      -- Difficulty_Get --
      --------------------

      function Difficulty_Get return Level is
      begin
         return User.Difficulty;
      end Difficulty_Get;

   end User_Access;

   --------------
   -- Get_User --
   --------------

   procedure Set_User is
      check_Input : Boolean := True;
   begin
      Put_Line ("Your Username: ");
      User_Protected.Name_Set (Get_Line);
      loop
         Put_Line ("Choose Level(1=easy, 2=hard): ");
         User_Protected.Difficulty_Set (Integer'Value (Get_Line), check_Input);
         exit when check_Input;
         Put_Line ("Wrong Level, use value 1=easy or 2=hard!!");
      end loop;
   end Set_User;

   procedure Print_User is
   begin
      Put ("Username: ");
      Put_Line (User_Protected.Name_Get);
      Put ("Level (1=easy, 2=hard): ");
      Put_Line (User_Protected.Difficulty_Get'Img);
      Put_Line ("");
      Put_Line ("");
   end Print_User;

   procedure Print_Explanation is
   begin
      Put ("Hi "); Put (User_Protected.Name_Get); Put ("!");
      Put_Line ("");
      Put_Line ("Welcome to the Math Game!");
      Put_Line ("You will be provided with 10 tasks to solve whereby your"
        & "processing time is measured");
      Put_Line ("In 5 seconds the first task will be shown!");
      delay 5.0;
   end Print_Explanation;

   procedure Print_Equation_Integer (Left : Integer; Right : Integer;
                                     Operation : Operation_Type) is
   begin
      Put (Left'Img);
      case Operation is
         when ADD => Put (" +");
         when SUB => Put (" -");
         when MUL => Put (" *");
         when DIV => Put (" /");
      end case;
      Put (Right'Img);
      Put (" =");
   end Print_Equation_Integer;

   procedure Print_Equation_Float (Left : Float; Right : Float;
                                   Operation : Operation_Type) is
   begin
      Put (Left, Aft => 2, Exp => 0);
      case Operation is
         when ADD => Put (" + ");
         when SUB => Put (" - ");
         when MUL => Put (" * ");
         when DIV => Put (" / ");
      end case;
      Put (Right, Aft => 2, Exp => 0);
      Put (" = ");
   end Print_Equation_Float;

   function Get_Result return String is
   begin
      return Get_Line;
   end Get_Result;

end UserInterface;
