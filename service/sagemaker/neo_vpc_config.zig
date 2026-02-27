/// The
/// [VpcConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_VpcConfig.html) configuration object that specifies the VPC that you want the compilation jobs to connect to. For more information on controlling access to your Amazon S3 buckets used for compilation job, see [Give Amazon SageMaker AI Compilation Jobs Access to Resources in Your Amazon VPC](https://docs.aws.amazon.com/sagemaker/latest/dg/neo-vpc.html).
pub const NeoVpcConfig = struct {
    /// The VPC security group IDs. IDs have the form of `sg-xxxxxxxx`. Specify the
    /// security groups for the VPC that is specified in the `Subnets` field.
    security_group_ids: []const []const u8,

    /// The ID of the subnets in the VPC that you want to connect the compilation
    /// job to for accessing the model in Amazon S3.
    subnets: []const []const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnets = "Subnets",
    };
};
