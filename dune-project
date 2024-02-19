(lang dune 3.13)

(name towerfmt)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Author Name")

(maintainers "Maintainer Name")

(license MIT)

(documentation https://url/to/documentation)

(package
 (name towerfmt)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends ocaml dune dream containers angstrom)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
