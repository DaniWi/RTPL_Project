with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with GenericOperation;
use GenericOperation;

package UserInterface is
   type Level is range 1 .. 2;
   type User_Type is record
      Name : Unbounded_String;
      Difficulty : Level := 1;
   end record;

   protected type User_Access is
      procedure Name_Set (Name : String);
      function Name_Get return String;
      procedure Difficulty_Set (Difficulty : Integer;
                                Check_Input : out Boolean);
      function Difficulty_Get return Level;
   private
      User : User_Type := (Name => To_Unbounded_String ("Test"),
                           Difficulty => 1);
   end User_Access;

   User_Protected : User_Access;

   procedure Set_User;
   procedure Print_User;
   procedure Print_Explanation;
   procedure Print_Equation_Integer (Left : Integer; Right : Integer;
                                     Operation : Operation_Type);
   procedure Print_Equation_Float (Left : Float; Right : Float;
                                   Operation : Operation_Type);
   function Get_Result return String;
end UserInterface;
