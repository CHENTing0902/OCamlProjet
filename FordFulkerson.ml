open Graph
open List

(* find seule route par source à sink *)

let findPath graph source sink =
	let marque = Hashtbl.create 40 in	
	let rec f path firstnode = 
		Hashtbl.add marque firstnode firstnode;
		let info = find_vertex graph firstnode in
		let outedges = info.outedges in
		let rec loop = function
			| [] -> []
			| (b,a)::c -> 
				if  (Hashtbl.mem marque a)||(b=0) then loop c
				else	
						if (a=sink) then ((info.id, a, b)::path)
						else
								let res = f((info.id, a, b)::path) a in
								if res = [] then (loop c) else res			
		in
		loop outedges in
		f [] source
(* find the min number of the list collection finded before *)
let rec minflow edges = match edges with 
	|[]->0
	|(a,b,x)::[] -> if x > 0 then x else 0
	|(a,b,x)::(c,d,y)::rest -> if x < y then minflow ((a,b,x)::rest) else minflow ((c,d,y)::rest)


(*  update the graph [ for all the lignes needed to be changed]   *)
let changeligne graph needtochangeligne minnumber = 
	let (id1,id2,distance) = needtochangeligne in
	add_edge graph id1 id2 (distance-minnumber);
 	let newg= graph in
	newg

		
let rec changegraph graph minnumber edgeslist = match edgeslist with
	|[]-> graph
	|(id1,id2,distance)::rest-> changegraph (changeligne graph (id1,id2,distance) minnumber) minnumber rest


(* main function*)
let rec main graph source sink  flow = 

		let edgeslist = findPath graph source sink in
			if (minflow edgeslist) = 0 then flow else
		 main (changegraph graph (minflow edgeslist) (edgeslist)) source sink  (flow+(minflow edgeslist))




(* seule route par source à sink 
let rec loop acc graph source sink = 
		let vertex_info = find_vertex graph source in
		let edges = vertex_info.outedges in 
			match edges with
				|(e,s)::rest when s = sink -> acc
				|[] -> []
				|(e,id1)::rest ->  if (loop ((vertex_info.id,id1,e)::acc) graph id1 sink) = [] then  aux rest vertex_info.id  graph sink else
								loop ((vertex_info.id,id1,e)::acc) graph id1 sink
	and  aux l s graph sink = match l with
	|[] -> []
	|(e, id)::rest -> loop [(s,id,e)] graph id sink
*)
(*let flow graph source sink = *)
