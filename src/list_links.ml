open Mechaml
module M = Agent.Monad
open M.Infix
open Printf

type state = Ok of string | Error of string * exn


let dummy_print to_print = 
  printf "%s\n" to_print;;





let list_links source max_depth = 
  Agent.get source
  >|= (fun response ->
    response
    |> Agent.HttpResponse.page
    |> Page.links
    |> Page.to_list
  )

let _ =
  list_links "https://www.onna.com" 1
  |> M.run (Agent.init ())
  |> snd
  |> List.iter (fun url -> 
    url
    |> Page.Link.href
    |> dummy_print
  )
