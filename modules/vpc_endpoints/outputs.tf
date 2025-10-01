output "endpoints" {
  value = {
    ecr_api  = aws_vpc_endpoint.ecr_api.id
    ecr_dkr  = aws_vpc_endpoint.ecr_dkr.id
    logs     = aws_vpc_endpoint.logs.id
    secrets  = aws_vpc_endpoint.secrets.id
    ssm      = aws_vpc_endpoint.ssm.id
  }
}
