data "external" "whoami" {
  program = ["${path.module}/_common/config/whoami.sh"]
}
