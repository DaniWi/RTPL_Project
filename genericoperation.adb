package body GenericOperation is

   ---------------
   -- Operation --
   ---------------

   function Operation (Left, Right : Element_Type; Operation : Operation_Type) return Element_Type is
      Result : Element_Type;
   begin
      case Operation is
         when ADD => Result := Left + Right;
         when SUB => Result := Left - Right;
         when MUL => Result := Left * Right;
         when DIV => Result := Left / Right;
         when others => null;
      end case;
      return Result;
   end Operation;

end GenericOperation;
