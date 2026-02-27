/// The advanced settings for a load balancer used in blue/green deployments.
/// Specify the
/// alternate target group, listener rules, and IAM role required for traffic
/// shifting during
/// blue/green deployments. For more information, see [Required resources for
/// Amazon ECS
/// blue/green
/// deployments](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/blue-green-deployment-implementation.html) in the *Amazon Elastic Container Service Developer Guide*.
pub const AdvancedConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the alternate target group for Amazon ECS
    /// blue/green deployments.
    alternate_target_group_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) that that identifies the production listener
    /// rule (in the case of an Application Load Balancer) or
    /// listener (in the case for an Network Load Balancer) for routing production
    /// traffic.
    production_listener_rule: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the IAM role that grants Amazon ECS
    /// permission to call the Elastic Load Balancing APIs for you.
    role_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) that identifies ) that identifies the test
    /// listener rule (in the case of an Application Load Balancer) or
    /// listener (in the case for an Network Load Balancer) for routing test
    /// traffic.
    test_listener_rule: ?[]const u8,

    pub const json_field_names = .{
        .alternate_target_group_arn = "alternateTargetGroupArn",
        .production_listener_rule = "productionListenerRule",
        .role_arn = "roleArn",
        .test_listener_rule = "testListenerRule",
    };
};
