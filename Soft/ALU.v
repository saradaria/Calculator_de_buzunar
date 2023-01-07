`timescale 1ns / 1ps

module ALU(
    input [7:0] a,b,c, //a - registru, b - imm, c - acc
    input [5:0] opcode,
    output reg [15:0] result,
    output reg Z_out, N_out, C_out, O_out
);

 initial begin
   Z_out = 1'd0;
   N_out = 1'd0;
   C_out = 1'd0;
   O_out = 1'd0;
 end
 
 integer i;
 
 always @(*) begin
   case(opcode)
     6'b001001: //ADD
      begin
        if(b == 8'bx)begin
          {C_out,result} <= a + c;
          if(result < 0) N_out <= 1'd1;
          else N_out <= 1'd0;
          Z_out <= ~(|result);
          O_out <= ({C_out,result[15]} == 2'b01);
        end
        else begin
          {C_out,result} <= a + b;
          if(result < 0) N_out <= 1'd1;
          else N_out <= 1'd0;
          Z_out <= ~(|result);
          O_out <= ({C_out,result[15]} == 2'b01);
       end
     end
     
     6'b001010: //SUB 
      begin
        if(b == 8'bx) begin
          {C_out,result} <= a - c;
          if(result < 0) N_out <= 1'd1;
          else N_out = 1'd0;
          Z_out <= ~(|result);
          O_out <= ({C_out,result[15]} == 2'b01);
        end
        else begin
          {C_out,result} <= a - b;
          if(result < 0) N_out <= 1'd1;
          else N_out = 1'd0;
          Z_out <= ~(|result);
          O_out <= ({C_out,result[15]} == 2'b01);
        end
     end 
         
     6'b001011: //LSR 
      begin
        if(b == 8'bx)begin
          for(i = 0; i < c; i = i + 1)
            {result, C_out } <= {1'b0, a};
          Z_out <= ~(|result);
          //O_out <= ({C_out,result[15]} == 2'b01);          
        end
        else begin
          for(i = 0; i < b; i = i + 1)
            {result, C_out } <= {1'b0, a};
          Z_out <= ~(|result);
          //O_out <= ({C_out,result[15]} == 2'b01);          
       end
     end  
     
     6'b001100: //LSL
      begin
        if(b == 8'bx) begin
          for(i = 0; i < c; i = i + 1)
            {result, C_out } <= {a, 1'b0};
          
          Z_out <= ~(|result);
          if(result < 0) N_out <= 1'd1;
          else N_out = 1'd0;
          //O_out <= ({C_out,result[15]} == 2'b01);  
        end
        else begin
          for(i = 0; i < b; i = i + 1)
            {result, C_out } <= {a, 1'b0};
          
         Z_out <= ~(|result);
          if(result < 0) N_out <= 1'd1;
          else N_out = 1'd0;
          //O_out <= ({C_out,result[15]} == 2'b01);          
        end
          
     end 
        
     6'b001101: //RSR
      begin
        {result}<={a[0],a[7:1]};
        
        if(result < 0) N_out <= 1'd1;
        else N_out = 1'd0;  
          
        Z_out <= ~(|result);
      end 
     
     6'b001110: //RSL
      begin
        {result}<={a[6:0],a[7]};
        
        if(result < 0) N_out <= 1'd1;
        else N_out = 1'd0;  
          
        Z_out <= ~(|result);       
      end
     
     6'b001111: //MOV
      begin

          result <= a;
          if(result < 0) N_out <= 1'd1;
          else N_out = 1'd0;
          Z_out <= ~(|result); 
        
      end
     
     6'b010000: //MUL
      begin
        if(b == 8'bx) begin
          {C_out,result} <= a * c;
        
          if(result < 0) N_out <= 1'd1;
          else N_out = 1'd0;
          Z_out <= ~(|result);  
       end
       else begin  
          {C_out,result} <= a * b;
        
          if(result < 0) N_out <= 1'd1;
          else N_out = 1'd0;
          Z_out <= ~(|result); 
      end
     end
     
     6'b010001: //DIV
      begin
        if(b == 8'bx) begin
          result <= a / c;
        
          if(result < 0) N_out <= 1'd1;
          else N_out = 1'd0;
          
          if(a < b) Z_out = 1'd1;
          else Z_out = 1'd0;          
        end
        else begin
          result <= a / b;
        
          if(result < 0) N_out <= 1'd1;
          else N_out = 1'd0;
          
          if(a < b) Z_out = 1'd1;
          else Z_out = 1'd0; 
        end
     end

     6'b010010: //MOD
      begin
        if(b == 8'bx)begin
          result <= a % c; 
          Z_out <= ~(|result);           
        end
        else begin
          result <= a % b; 
          Z_out <= ~(|result); 
        end
        
     end
     
     6'b010011: //AND
      begin
        if(b == 8'bx) begin
          result <= a & c; 
        
          if(result < 0) N_out <= 1'd1;
          else N_out <= 1'd0;
          
          Z_out <= ~(|result); 
        end
        else begin
          result <= a & b; 
          
          if(result < 0) N_out <= 1'd1;
          else N_out <= 1'd0;
          
          Z_out <= ~(|result);           
       end
     end
     
     6'b010100: //OR
      begin
        
        if(b == 8'bx)begin
          result <= a | c; 
        
          if(result < 0) N_out <= 1'd1;
          else N_out <= 1'd0;
          
          Z_out <= ~(|result);  
        end
        else begin
          result <= a | b; 
        
          if(result < 0) N_out <= 1'd1;
          else N_out <= 1'd0;
          
          Z_out <= ~(|result);           
        end
     end
     
     6'b010101: //XOR
      begin
        
        if(b == 8'bx) begin
          result <= a ^ c; 
        
          if(result < 0) N_out <= 1'd1;
          else N_out <= 1'd0;
          
          Z_out <= ~(|result);            
        end 
        else begin
          result <= a ^ b; 
        
          if(result < 0) N_out <= 1'd1;
          else N_out <= 1'd0;
          
          Z_out <= ~(|result);                 
        end

     end
     
     6'b010110: //NOT
      begin
        
         result <= ~a; 
        
         if(result < 0) N_out <= 1'd1;
         else N_out <= 1'd0;
          
         Z_out <= ~(|result);           
             
      end

     6'b010111: //CMP
      begin
        
        if(b == 8'bx) begin
          {C_out,result} <= a - c;
          if(result < 0) N_out <= 1'd1;
          else N_out = 1'd0;
          Z_out <= ~(|result);
          O_out <= ({C_out,result[15]} == 2'b01);         
        end
        else begin
          {C_out,result} <= a - b;
          if(result < 0) N_out <= 1'd1;
          else N_out = 1'd0;
          Z_out <= ~(|result);
          O_out <= ({C_out,result[15]} == 2'b01);
       end          
     end
    
     6'b011000: //TST  //same as AND but result should be discarded!
      begin
        if(b == 8'bx) begin
          result <= a & c; 
        
          if(result < 0) N_out <= 1'd1;
          else N_out <= 1'd0;
          
          Z_out <= ~(|result); 
        end
        else begin
          result <= a & b; 
          
          if(result < 0) N_out <= 1'd1;
          else N_out <= 1'd0;
          
          Z_out <= ~(|result);           
       end
      end 
     
     6'b011001: //INC
      begin
          {C_out,result} <= a + 1;
          if(result < 0) N_out <= 1'd1;
          else N_out = 1'd0;
          Z_out <= ~(|result);
          O_out <= ({C_out,result[15]} == 2'b01);  
     end        
     
     6'b011010: //DEC
      begin
          {C_out,result} <= a - 1;
          if(result < 0) N_out <= 1'd1;
          else N_out = 1'd0;
          Z_out <= ~(|result);
          O_out <= ({C_out,result[15]} == 2'b01);
         
      end
         
   endcase
 end

endmodule
