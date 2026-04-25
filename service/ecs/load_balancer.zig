const AdvancedConfiguration = @import("advanced_configuration.zig").AdvancedConfiguration;

/// The load balancer configuration to use with a service or task set.
///
/// When you add, update, or remove a load balancer configuration, Amazon ECS
/// starts a new deployment with the updated Elastic Load Balancing
/// configuration. This causes tasks to register to and deregister from load
/// balancers.
///
/// We recommend that you verify this on a test environment before you update
/// the Elastic Load Balancing configuration.
///
/// A service-linked role is required for services that use multiple target
/// groups. For more information, see [Using service-linked
/// roles](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using-service-linked-roles.html) in the *Amazon Elastic Container Service Developer Guide*.
pub const LoadBalancer = struct {
    /// The advanced settings for the load balancer used in blue/green deployments.
    /// Specify the alternate target group, listener rules, and IAM role required
    /// for traffic shifting during blue/green deployments.
    advanced_configuration: ?AdvancedConfiguration = null,

    /// The name of the container (as it appears in a container definition) to
    /// associate with the load balancer.
    ///
    /// You need to specify the container name when configuring the target group for
    /// an Amazon ECS load balancer.
    container_name: ?[]const u8 = null,

    /// The port on the container to associate with the load balancer. This port
    /// must correspond to a `containerPort` in the task definition the tasks in the
    /// service are using. For tasks that use the EC2 launch type, the container
    /// instance they're launched on must allow ingress traffic on the `hostPort` of
    /// the port mapping.
    container_port: ?i32 = null,

    /// The name of the load balancer to associate with the Amazon ECS service or
    /// task set.
    ///
    /// If you are using an Application Load Balancer or a Network Load Balancer the
    /// load balancer name parameter should be omitted.
    load_balancer_name: ?[]const u8 = null,

    /// The full Amazon Resource Name (ARN) of the Elastic Load Balancing target
    /// group or groups associated with a service or task set.
    ///
    /// A target group ARN is only specified when using an Application Load Balancer
    /// or Network Load Balancer.
    ///
    /// For services using the `ECS` deployment controller, you can specify one or
    /// multiple target groups. For more information, see [Registering multiple
    /// target groups with a
    /// service](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/register-multiple-targetgroups.html) in the *Amazon Elastic Container Service Developer Guide*.
    ///
    /// For services using the `CODE_DEPLOY` deployment controller, you're required
    /// to define two target groups for the load balancer. For more information, see
    /// [Blue/green deployment with
    /// CodeDeploy](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-type-bluegreen.html) in the *Amazon Elastic Container Service Developer Guide*.
    ///
    /// If your service's task definition uses the `awsvpc` network mode, you must
    /// choose `ip` as the target type, not `instance`. Do this when creating your
    /// target groups because tasks that use the `awsvpc` network mode are
    /// associated with an elastic network interface, not an Amazon EC2 instance.
    /// This network mode is required for the Fargate launch type.
    target_group_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .advanced_configuration = "advancedConfiguration",
        .container_name = "containerName",
        .container_port = "containerPort",
        .load_balancer_name = "loadBalancerName",
        .target_group_arn = "targetGroupArn",
    };
};
