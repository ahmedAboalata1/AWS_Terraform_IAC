# Create Auto Scaling Group
resource "aws_launch_configuration" "app" {
  name                 = "app-launch-configuration"
  image_id             = "ami-0ebfd941bbafe70c6"
  instance_type        = "t2.micro"
  key_name             = "project"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  security_groups      = [aws_security_group.HTTP-SG.id]
  user_data            = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y python3
    echo "Hello, World from ASG , $(hostname -f) " > /home/ec2-user/index.html
    cd /home/ec2-user
    python3 -m http.server 80 &
    EOF
}
resource "aws_autoscaling_group" "app" {
  name                 = "ASG"
  launch_configuration = aws_launch_configuration.app.id
  min_size             = 2
  max_size             = 2
  desired_capacity     = 2
  vpc_zone_identifier  = [aws_subnet.private-sub1.id, aws_subnet.private-sub2.id]

  target_group_arns = [aws_lb_target_group.targetgroup.arn]
  tag {
    key                 = "Name"
    value               = "ASG_Instance"
    propagate_at_launch = true
  }
}
