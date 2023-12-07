# avx-ecs-github-runners
 
```hcl
module "aws_ecs_github_runner" {
  source = "git::https://github.com/rstuhlmuller/aws-ecs-github-runners.git?ref=main"

  cluster_name       = "Self-Hosted-Github-Runners"
  security_group_ids = ["<sg_1>"]
  subnet_ids = [
    "<subnet_1>",
    "<subnet_2>"
  ]

  runners = {
    runner_1 = {
      org        = "My_Org"
      labels     = "aws,ecs,private"
    }
    runner_2 = {
      org        = "My_Org"
      labels     = "aws,ecs"
    }
  }

  providers = {
    aws = aws
  }
}
```