open Graph
open FordFulkerson

let () =

  if Array.length Sys.argv <> 6 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile  flow\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  let infile = Sys.argv.(1)
  and _source = Sys.argv.(2)
  and _sink = Sys.argv.(3)
  and outfile = Sys.argv.(4) 
 
  and flow = Sys.argv.(5) in

  let graph = Gfile.from_file infile in

  (* Rewrite the graph that has been read. *)
  (* let () = Gfile.write_file outfile graph in*)
  (*let () = Gfile.export outfile graph in


  let graph2 = Graph.map graph int_of_string int_of_string in
  let graph3 = Graph.map graph2 (fun x -> x+1) (fun x -> x+2) in
  let graph4 = Graph.map graph3 string_of_int string_of_int in*)

  
  let graph2 = Graph.map graph int_of_string int_of_string in
 	let f = int_of_string(flow) in
  	let a =  FordFulkerson.main graph2 _source _sink  f in
	let () = Gfile.export outfile (Graph.map graph2 string_of_int string_of_int) in
	Printf.printf "%d \n" a;
  






