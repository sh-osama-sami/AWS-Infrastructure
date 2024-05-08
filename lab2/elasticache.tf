#aws elasticache
resource "aws_elasticache_subnet_group" "elasticache_subnet_group" {
  name       = "elasticache-subnet-group"
  subnet_ids = [module.network.private_subnet_1_id, module.network.private_subnet_2_id]
}

resource "aws_elasticache_cluster" "elasticache_cluster" {
  cluster_id           = "my-elasticache-cluster"
  engine               = "redis"
  engine_version       = "5.0.6"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.elasticache_subnet_group.name
  security_group_ids   = [aws_security_group.elasticache_sg.id]
  tags = {
    Name = "my-elasticache-cluster"
  }
}
