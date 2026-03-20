module "vpc" {
  source               = "../../modules/vpc"
  name                 = "${var.project_name}-vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr
  az1                  = var.az1
  az2                  = var.az2
}

module "sg" {
  source = "../../modules/security-groups"
  name   = var.project_name
  vpc_id = module.vpc.vpc_id
}

module "iam_ssm" {
  source = "../../modules/iam-ssm"
  name   = var.project_name
}

module "web_server" {
  source                = "../../modules/ec2-linux"
  name                  = "${var.project_name}-web"
  ami_id                = var.linux_ami_id
  instance_type         = var.linux_instance_type
  subnet_id             = module.vpc.public_subnet_1_id
  security_group_id     = module.sg.linux_web_sg_id
  instance_profile_name = module.iam_ssm.instance_profile_name
}

module "linux_agent" {
  source                = "../../modules/ec2-linux"
  name                  = "${var.project_name}-linux-agent"
  ami_id                = var.linux_ami_id
  instance_type         = var.linux_instance_type
  subnet_id             = module.vpc.public_subnet_1_id
  security_group_id     = module.sg.linux_agent_sg_id
  instance_profile_name = module.iam_ssm.instance_profile_name
}

module "windows_agent" {
  source                = "../../modules/ec2-windows"
  name                  = "${var.project_name}-windows-agent"
  ami_id                = var.windows_ami_id
  instance_type         = var.windows_instance_type
  subnet_id             = module.vpc.public_subnet_2_id
  security_group_id     = module.sg.windows_agent_sg_id
  instance_profile_name = module.iam_ssm.instance_profile_name
}

module "alb" {
  source             = "../../modules/alb"
  name               = "${var.project_name}-alb"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
  alb_sg_id          = module.sg.alb_sg_id
  target_instance_id = module.web_server.instance_id
}

module "artifacts" {
  source      = "../../modules/s3-artifacts"
  bucket_name = var.artifact_bucket_name
}
