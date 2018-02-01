package GenericOperation is
   type Operation_Type is (ADD, SUB, MUL, DIV);
   generic 
      type Element_Type is private;
      with function "+" (Left, Right: Element_Type) return Element_Type is <>;
      with function "-" (Left, Right: Element_Type) return Element_Type is <>;
      with function "*" (Left, Right: Element_Type) return Element_Type is <>;
      with function "/" (Left, Right: Element_Type) return Element_Type is <>;
   
   function Operation(Left, Right : Element_Type; Operation : Operation_Type) return Element_Type;

end GenericOperation;
