open Core_kernel

let () =
  let open Lacaml.D in
  let d = 50 in
  let n = 20 in
  let x_pos = Array.init n ~f:(fun _ -> Array.init d ~f:(fun _ -> Random.float 1.)) in
  let x_neg = Array.init n ~f:(fun _ -> Array.init d ~f:(fun _ -> Random.float 1.)) in
  let x = Mat.of_array (Array.append x_pos x_neg) in
  let y = Vec.init (2 * n) (fun i -> if i < n then 1. else 0.) in
  let _prob = Libsvm.Svm.Problem.create ~x ~y in
  Gc.full_major ()
