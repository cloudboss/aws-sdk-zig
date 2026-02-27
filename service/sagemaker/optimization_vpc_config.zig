/// A VPC in Amazon VPC that's accessible to an optimized that you create with
/// an optimization job. You can control access to and from your resources by
/// configuring a VPC. For more information, see [Give SageMaker Access to
/// Resources in your Amazon
/// VPC](https://docs.aws.amazon.com/sagemaker/latest/dg/infrastructure-give-access.html).
pub const OptimizationVpcConfig = struct {
    /// The VPC security group IDs, in the form `sg-xxxxxxxx`. Specify the security
    /// groups for the VPC that is specified in the `Subnets` field.
    security_group_ids: []const []const u8,

    /// The ID of the subnets in the VPC to which you want to connect your optimized
    /// model.
    subnets: []const []const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnets = "Subnets",
    };
};
