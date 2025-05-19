open Towerfmt

(* eml is kinda bad *)
let home =
  {|<html>
    <head>
      <script src="https://unpkg.com/htmx.org@1.9.10" integrity="sha384-D1Kt99CQMDuVetoL1lrYwg5t+9QdHe7NLX/SoJYkXDFfX37iInKRy5xLSi8nO7UC" crossorigin="anonymous"></script>
    </head>
    <body>
      <h1>towerfmt</h1>
      <p>Instructions: Go to <a href="https://www.chiark.greenend.org.uk/~sgtatham/puzzles/js/towers.html">the Towers website</a>
        and select a puzzle. Then click the &quot;Link to this puzzle&quot; by game ID.
        Then copy the URL in the search bar and paste it below.
      </p>
      <form hx-get="/" hx-swap="afterend">
        <label for="url">url</label>
        <input name="url" />
        <button type="submit">submit</button>
      </form>
    </body>
  </html>|}

let () =
  Dream.run ~interface:"0.0.0.0" ~port:6868
  @@ Dream.logger (fun req ->
         match Dream.query req "url" with
         | None -> Dream.html home
         | Some url -> (
             Dream.log "url is %s" url;
             match Parse_tower.parse url with
             | Ok url ->
                 Dream.html (Format.asprintf "<pre>%a<pre>" Print_pl.pp url)
             | Error v -> Dream.html v))
