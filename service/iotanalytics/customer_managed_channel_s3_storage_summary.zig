/// Used to store channel data in an S3 bucket that you manage.
pub const CustomerManagedChannelS3StorageSummary = struct {
    /// The name of the S3 bucket in which channel data is stored.
    bucket: ?[]const u8 = null,

    /// (Optional) The prefix used to create the keys of the channel data objects.
    /// Each object in
    /// an S3 bucket has a key that is its unique identifier within the bucket (each
    /// object in a
    /// bucket has exactly one key). The prefix must end with a forward slash (/).
    key_prefix: ?[]const u8 = null,

    /// The ARN of the role that grants IoT Analytics permission to interact with
    /// your Amazon S3
    /// resources.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key_prefix = "keyPrefix",
        .role_arn = "roleArn",
    };
};
