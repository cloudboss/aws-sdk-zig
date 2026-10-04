const VpcConfigInput = @import("vpc_config_input.zig").VpcConfigInput;

/// A structure that specifies a replica location for a canary, including the
/// Region and optional VPC configuration.
pub const AddReplicaLocationInput = struct {
    /// The Amazon Resource Name (ARN) of the customer-managed AWS Key Management
    /// Service (AWS KMS) key used to encrypt the canary replica's
    /// AWS Lambda function environment variables at rest. If you don't specify a
    /// value,
    /// the service uses an AWS-managed key.
    kms_key_arn: ?[]const u8 = null,

    /// The Amazon Web Services Region where the canary replica should be created,
    /// for example `us-east-1`.
    location: []const u8,

    /// The VPC configuration to use for the canary replica in this location. If not
    /// specified, the replica runs without VPC connectivity.
    vpc_config: ?VpcConfigInput = null,

    pub const json_field_names = .{
        .kms_key_arn = "KmsKeyArn",
        .location = "Location",
        .vpc_config = "VpcConfig",
    };
};
