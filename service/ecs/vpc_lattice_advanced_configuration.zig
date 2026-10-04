/// The advanced settings for VPC Lattice used in blue/green deployments.
/// Specify the alternate target group and listener rules required for traffic
/// shifting during blue/green deployments. For more information, see [Required
/// resources for Amazon ECS blue/green
/// deployments](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/blue-green-deployment-implementation.html) in the *Amazon Elastic Container Service Developer Guide*.
pub const VpcLatticeAdvancedConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the alternate target group associated with
    /// the VPC Lattice Configuration for Amazon ECS blue/green deployments.
    alternate_target_group_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that identifies the production listener rule
    /// or listener for routing production traffic.
    production_listener_rule: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that identifies the test listener rule or
    /// listener for routing test traffic.
    test_listener_rule: ?[]const u8 = null,

    pub const json_field_names = .{
        .alternate_target_group_arn = "alternateTargetGroupArn",
        .production_listener_rule = "productionListenerRule",
        .test_listener_rule = "testListenerRule",
    };
};
