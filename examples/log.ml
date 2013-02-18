open Core.Std
open Lacaml.D
open Libsvm

(* In order to compile this program, install the additional packages:
   1. gsl-ocaml: https://bitbucket.org/mmottl/gsl-ocaml or type 'opam install gsl-ocaml'
   2. ocaml-gnuplot: http://sourceforge.net/projects/ocaml-gnuplot/
*)
module Gp = Gnuplot.Array

let red = 0xFF0000
let green = 0x00AA00
let blue = 0x0000FF

let a = 0.1
let b = 5.0
let n_inputs = 99
let sigma = 0.2

let gen_data () =
  let default_rng = Gsl.Rng.make (Gsl.Rng.default ()) in
  let noise = Vec.init n_inputs (fun _ -> Gsl.Randist.gaussian default_rng ~sigma) in
  let inputs = Vec.linspace a b n_inputs in
  let targets = Vec.add (Vec.map log inputs) noise in
  Mat.from_col_vec inputs, targets

let plot g ~x ~y ~color =
  Gp.color g color;
  Gp.xy g (Vec.to_array x) (Vec.to_array y) ~style:Gp.Points

let () =
  let inputs, targets = gen_data () in
  let problem = Svm.Problem.create ~x:inputs ~y:targets in
  let model = Svm.train ~svm_type:`NU_SVR problem in
  let preds = Svm.predict model ~x:inputs in
  let inputs = Mat.as_vec inputs in
  let g = Gp.init ~xsize:500. ~ysize:300. Gp.Wxt in
  Gp.box g;
  Gp.title g "log";
  Gp.pen g 3;
  Gp.pen_width g 2.;
  Gp.color g green;
  Gp.fx g log a b;
  plot g ~x:inputs ~y:targets ~color:red;
  plot g ~x:inputs ~y:preds ~color:blue;
  Gp.close g
