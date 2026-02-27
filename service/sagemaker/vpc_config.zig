/// Specifies an Amazon Virtual Private Cloud (VPC) that your SageMaker jobs,
/// hosted models, and compute resources have access to. You can control access
/// to and from your resources by configuring a VPC. For more information, see
/// [Give SageMaker Access to Resources in your Amazon
/// VPC](https://docs.aws.amazon.com/sagemaker/latest/dg/infrastructure-give-access.html).
pub const VpcConfig = struct {
    /// The VPC security group IDs, in the form `sg-xxxxxxxx`. Specify the security
    /// groups for the VPC that is specified in the `Subnets` field.
    security_group_ids: []const []const u8,

    /// The ID of the subnets in the VPC to which you want to connect your training
    /// job or model. For information about the availability of specific instance
    /// types, see [Supported Instance Types and Availability
    /// Zones](https://docs.aws.amazon.com/sagemaker/latest/dg/instance-types-az.html).
    subnets: []const []const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnets = "Subnets",
    };
};
