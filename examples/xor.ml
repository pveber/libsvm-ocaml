open Core.Std
open Lacaml.D
open Libsvm

let () =
  let x = Mat.of_array
    [|
      [| 0.; 0. |];
      [| 0.; 1. |];
      [| 1.; 0. |];
      [| 1.; 1. |];
    |]
  in
  let target = Vec.of_array [| 0.; 1.; 1.; 0. |] in
  let problem = Svm.Problem.create ~x ~y:target in
  let model = Svm.train problem in
  let preds = Svm.predict model ~x in
  Array.iter2_exn (Mat.to_array x) (Vec.to_array preds) ~f:(fun x y ->
    printf "(%1.0f, %1.0f) -> %1.0f\n" x.(0) x.(1) y)
