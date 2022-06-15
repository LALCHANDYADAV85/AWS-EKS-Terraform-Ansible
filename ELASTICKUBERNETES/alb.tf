resource "aws_lb_target_group" "eks_alb_tg" {
  name        = "TargetGroup"
  port        = 80
  target_type = "instance"
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_alb_target_group_attachment" "eks_alb_tg_attachment" {
  count            = length(module.eks.node_groups)
  target_group_arn = aws_lb_target_group.eks_alb_tg.arn
  target_id        = module.eks.node_groups[count.index].id
}

resource "aws_lb" "eks_alb" {
  name               = "EKS-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.eks_public_elb.id, ]
  subnets            = module.vpc.public_subnets
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.eks_alb.arn
  port              = "80"
  protocol          = "HTTP"

   default_action {
     type = "redirect"

     redirect {
       port        = "443"
       protocol    = "HTTPS"
       status_code = "HTTP_301"
    }
  }
}



resource "aws_lb_listener_rule" "static" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.eks_alb_tg.arn

  }

   condition {
     path_pattern {
       values = ["/var/www/html/index.html"]
    }
  }
}
