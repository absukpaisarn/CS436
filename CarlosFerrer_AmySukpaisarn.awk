BEGIN {
   time1 = 0.0;
   time2 = 0.0;
   timeInterval = 0.0;
}

{
   time2 = $2;

   timeInterval = time2 - time1;

   if ( timeInterval > 0.5) 
   {
		# 8 / RED
		throughput_flow10 = bytes_counter_flow10 / timeInterval;
		throughput_flow11 = bytes_counter_flow11 / timeInterval;
		throughput_flow14 = bytes_counter_flow14 / timeInterval;
		throughput_flow16 = bytes_counter_flow16 / timeInterval;
   
		# 9 / BLUE
		throughput_flow12 = bytes_counter_flow12 / timeInterval;
		throughput_flow13 = bytes_counter_flow13 / timeInterval;
		throughput_flow15 = bytes_counter_flow15 / timeInterval;
		throughput_flow17 = bytes_counter_flow17 / timeInterval;
		
		printf("%f \t %f \t %f \t %f \t %f  \t %f  \t %f  \t %f  \t %f \n", time2, throughput_flow10, throughput_flow11, throughput_flow14, throughput_flow16, throughput_flow12, throughput_flow13, throughput_flow15, throughput_flow17) > "all_throughput.xls";
		printf("%f \t %f \n", time2, throughput_flow11) > "8-11_throughput.xls";
		printf("%f \t %f \n", time2, throughput_flow12) > "9-12_throughput.xls";
		printf("%f \t %f \n", time2, throughput_flow16) > "8-16_throughput.xls";
		printf("%f \t %f \n", time2, throughput_flow17) > "9-17_throughput.xls";
		
		bytes_counter_flow10 = 0;
		bytes_counter_flow11 = 0;
		bytes_counter_flow14 = 0;
		bytes_counter_flow16 = 0;
		
		bytes_counter_flow12 = 0;
		bytes_counter_flow13 = 0;
		bytes_counter_flow15 = 0;
		bytes_counter_flow17 = 0;
		
		time1 = $2;
   }
   
   # 8 / BLUE
   if ($1 == "r" && $4 == 10 && $8 == 10) 
   {
		bytes_counter_flow10 += $6;
   }
   
   if ($1 == "r" && $4 == 11 && $8 == 11) 
   {
		bytes_counter_flow11 += $6;
   }
   
   if ($1 == "r" && $4 == 14 && $8 == 14) 
   {
		bytes_counter_flow14 += $6;
   }
   
   if ($1 == "r" && $4 == 16 && $8 == 16) 
   {
		bytes_counter_flow16 += $6;
   }
   
   
   # 9 / RED
   if ($1 == "r" && $4 == 12 && $8 == 12) 
   {
		bytes_counter_flow12 += $6;
   }
   
   if ($1 == "r" && $4 == 13 && $8 == 13) 
   {
		bytes_counter_flow13 += $6;
   }
   
   if ($1 == "r" && $4 == 15 && $8 == 15) 
   {
		bytes_counter_flow15 += $6;
   }
   
   if ($1 == "r" && $4 == 17 && $8 == 17) 
   {
		bytes_counter_flow17 += $6;
   }
   
}


END {
   print("****End of awk file****");
}