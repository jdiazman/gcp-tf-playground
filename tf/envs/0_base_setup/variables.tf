locals {
  envs = fileexists("../../../.env") ? { for tuple in regexall("(.*)=(.*)", file("../../../.env")) : tuple[0] => sensitive(tuple[1]) } : {}
}