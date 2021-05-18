
resource "aws_codepipeline" "iac_test_pipeline" {
  name     = "iac-test-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  tags = {
    Environment = var.env
  }

  artifact_store {
    location = var.artifacts_bucket_name
    type     = "S3"

  }

  stage {
    name = "Source"

    action {
      category = "Source"
      configuration = {
        "Branch"     = var.repository_branch
        "OAuthToken" = var.github_token
        "Owner"      = var.repository_owner
        "Repo"       = var.repository_name
      }
      input_artifacts = []
      name            = "Source"
      output_artifacts = [
        "SourceArtifact",
      ]
      owner     = "ThirdParty"
      provider  = "GitHub"
      run_order = 1
      version   = "1"
    }
  }
  stage {
    name = "Build"

    action {
      category = "Build"
      configuration = {
        "ProjectName" = "iac-test-build"
      }
      input_artifacts = [
        "SourceArtifact",
      ]
      name = "Build"
      output_artifacts = [
        "BuildArtifact",
      ]
      owner     = "AWS"
      provider  = "CodeBuild"
      run_order = 1
      version   = "1"
    }
  }
}

