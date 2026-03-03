const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Specifies the configuration for a Amazon SageMaker endpoint.
pub const SageMakerEndpoint = struct {
    /// The ARN of the IAM role that Amazon SageMaker can assume to access model
    /// artifacts and docker image for deployment on Amazon EC2 compute instances or
    /// for batch transform jobs.
    execution_role: []const u8,

    /// The number of Amazon EC2 compute instances to deploy for initial endpoint
    /// creation.
    initial_instance_count: i32,

    /// The Amazon EC2 compute instance type to deploy for hosting the model.
    instance_type: []const u8,

    /// The Amazon Web Services KMS key that Amazon SageMaker uses to encrypt data
    /// on the storage volume attached to the Amazon EC2 compute instance that hosts
    /// the endpoint.
    kms_encryption_key: ?[]const u8 = null,

    /// The VPC configuration for the endpoint.
    vpc: ?VpcConfig = null,

    pub const json_field_names = .{
        .execution_role = "executionRole",
        .initial_instance_count = "initialInstanceCount",
        .instance_type = "instanceType",
        .kms_encryption_key = "kmsEncryptionKey",
        .vpc = "vpc",
    };
};
