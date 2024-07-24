module procedural_2_q1();
  parameter quantum = 3; 	// quantum time
  parameter no_p = 5;       // no. of processess
  int arrival_time[no_p] = '{0,0,0,0,0};			//start time
  int execute_time[no_p] = '{8,9,11,5,4};			//respective process will execute till this many time stamps
  int pro_number[no_p] = '{0,1,2,3,4};				//process numbers as P0,P1,P2,P3,P4
  int pro_queue[$] = '{8,9,11,5,2};					//process queue for burst data
  int pro_name[$] = {0,1,2,3,4};					//process name
  int pop_pro, pop_pro_name;
  reg [4:0]pro_done;								//output for process completed
  always
    begin
      if(pro_queue[0] < quantum)                    //when execution time left is less than quantum time
        begin
          #(pro_queue[0]);
          pro_queue.pop_front();
          pop_pro_name = pro_name.pop_front();
          pro_done[pop_pro_name] = 1'b1;
        end
      else											// still execution time is left
        begin
          #quantum;
          pop_pro = pro_queue.pop_front();
          pop_pro_name = pro_name.pop_front();
          if((pop_pro - quantum)!=0)					//popped process and quantum time are not equal
            begin
              pro_queue.push_back(pop_pro - quantum);
              pro_name.push_back(pop_pro_name);
            end
          else											// popped process and quantum time are equal
            begin
              pro_done[pop_pro_name] = 1'b1;
            end
        end
    end
  always
    begin
      //$display("\n");
      $display("time = %0t | process_queue = %0p | process_name = %0p | output = %0b ", $time, pro_queue, pro_name , pro_done);
      #1;
      if(pro_done === 5'b11111)
        begin
          $display("time = %0t | process_queue = %0p | process_name = %0p | output = %0b", $time, pro_queue, pro_name, pro_done);
        end
    end
endmodule
