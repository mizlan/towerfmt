open Towerfmt

(* eml is kinda bad *)
let home =
  {|<html>
    <body>
      <form>
        <label for="url">url</label>
        <input name="url" />
        <button type="submit">submit</button>
      </form>
    </body>
  </html>|}

let () =
  Dream.run
  @@ Dream.logger (fun req ->
         match Dream.query req "url" with
         | None -> Dream.html home
         | Some url -> (
             Dream.log "url is %s" url;
             match Parse_tower.parse url with
             | Ok url ->
                 Dream.html (Format.asprintf "<pre>%a<pre>" Print_pl.pp url)
             | Error v -> Dream.html v))
