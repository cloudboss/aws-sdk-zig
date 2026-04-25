/// Information about a load balancer that the service uses.
pub const AwsEcsServiceLoadBalancersDetails = struct {
    /// The name of the container to associate with the load balancer.
    container_name: ?[]const u8 = null,

    /// The port on the container to associate with the load balancer. This port
    /// must correspond to a `containerPort` in the task definition the tasks in the
    /// service are using. For tasks that use the EC2 launch type, the container
    /// instance they are launched on must allow ingress traffic on the `hostPort`
    /// of the port mapping.
    container_port: ?i32 = null,

    /// The name of the load balancer to associate with the Amazon ECS service or
    /// task set.
    ///
    /// Only specified when using a Classic Load Balancer. For an Application Load
    /// Balancer or a Network Load Balancer, the load balancer name is omitted.
    load_balancer_name: ?[]const u8 = null,

    /// The ARN of the Elastic Load Balancing target group or groups associated with
    /// a service or task set.
    ///
    /// Only specified when using an Application Load Balancer or a Network Load
    /// Balancer. For a Classic Load Balancer, the target group ARN is omitted.
    target_group_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_name = "ContainerName",
        .container_port = "ContainerPort",
        .load_balancer_name = "LoadBalancerName",
        .target_group_arn = "TargetGroupArn",
    };
};
