/// Inference Recommender provisions SageMaker endpoints with access to VPC in
/// the inference recommendation job.
pub const RecommendationJobVpcConfig = struct {
    /// The VPC security group IDs. IDs have the form of `sg-xxxxxxxx`. Specify the
    /// security groups for the VPC that is specified in the `Subnets` field.
    security_group_ids: []const []const u8,

    /// The ID of the subnets in the VPC to which you want to connect your model.
    subnets: []const []const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnets = "Subnets",
    };
};
