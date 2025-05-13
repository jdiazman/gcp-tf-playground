terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = local.envs["PROJECT_ID"]
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_project_iam_member" "editor" {
    project = local.envs["PROJECT_ID"]
    role    = "roles/editor"
    member  = "user:${local.envs["MAIL"]}"
}

resource "google_project_iam_policy" "restrict_policy" {
    project = local.envs["PROJECT_ID"]

    policy_data = jsonencode({
        bindings = [
            {
                role    = "roles/editor"
                members = ["user:${local.envs["MAIL"]}"]
            }
        ]
    })
}