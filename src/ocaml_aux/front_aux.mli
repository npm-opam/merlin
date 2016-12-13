(* {{{ COPYING *(

  This file is part of Merlin, an helper for ocaml editors

  Copyright (C) 2013 - 2015  Frédéric Bour  <frederic.bour(_)lakaban.net>
                             Thomas Refis  <refis.thomas(_)gmail.com>
                             Simon Castellan  <simon.castellan(_)iuwt.fr>

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the "Software"),
  to deal in the Software without restriction, including without limitation the
  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
  sell copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  The Software is provided "as is", without warranty of any kind, express or
  implied, including but not limited to the warranties of merchantability,
  fitness for a particular purpose and noninfringement. In no event shall
  the authors or copyright holders be liable for any claim, damages or other
  liability, whether in an action of contract, tort or otherwise, arising
  from, out of or in connection with the software or the use or other dealings
  in the Software.

)* }}} *)

open Std

(** Raise an error that can be caught: normal flow is resumed if a
    [catch_errors] handler was installed. *)
val raise_error: ?ignore_unify:bool -> exn -> unit

(** Resume after error: like [raise_error], but if a handler was provided a
    Resume exception is raised.  This allows to specify a special case when an
    error is caught. *)
exception Resume
val resume_raise: exn -> 'a

(** Installing (and removing) error handlers. *)

(** Any [raise_error] invoked inside catch_errors will be added to the list. *)
val catch_errors: exn list ref -> (unit -> 'a) -> 'a

(** Temporary disable catching errors *)
val uncatch_errors: (unit -> 'a) -> 'a

(** Returns a reference initially set to false that will be set to true when a
    type error is raised. *)
val monitor_errors: unit -> bool ref

(** Warnings can also be stored in the caught exception list, wrapped inside
    this exception *)
exception Warning of Location.t * string

(* Keep track of type variables generated by error recovery. *)

val erroneous_type_register: Types.type_expr -> unit
val erroneous_type_check: Types.type_expr -> bool
val erroneous_expr_check: Typedtree.expression -> bool
val erroneous_patt_check: Typedtree.pattern -> bool
