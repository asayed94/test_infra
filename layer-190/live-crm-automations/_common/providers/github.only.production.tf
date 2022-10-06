resource "github_repository_project" "apply" {
  repository = data.terraform_remote_state.repositories.outputs.github-lessonnine-babbel-infrastructure.name

  name = "${var.layer}/${var.service}"
}

resource "github_project_column" "apply-todo" {
  project_id = github_repository_project.apply.id

  name = "TODO"
}

resource "github_project_column" "apply-applying" {
  project_id = github_repository_project.apply.id

  name = "Applying"
}

resource "github_project_column" "apply-done" {
  project_id = github_repository_project.apply.id

  name = "DONE"
}
