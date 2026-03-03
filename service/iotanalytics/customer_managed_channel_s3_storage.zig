/// Used to store channel data in an S3 bucket that you manage. If
/// customer-managed storage is
/// selected, the `retentionPeriod` parameter is ignored. You can't change the
/// choice
/// of S3 storage after the data store is created.
pub const CustomerManagedChannelS3Storage = struct {
    /// The name of the S3 bucket in which channel data is stored.
    bucket: []const u8,

    /// (Optional) The prefix used to create the keys of the channel data objects.
    /// Each object in
    /// an S3 bucket has a key that is its unique identifier in the bucket. Each
    /// object in a bucket
    /// has exactly one key. The prefix must end with a forward slash (/).
    key_prefix: ?[]const u8 = null,

    /// The ARN of the role that grants IoT Analytics permission to interact with
    /// your Amazon S3
    /// resources.
    role_arn: []const u8,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key_prefix = "keyPrefix",
        .role_arn = "roleArn",
    };
};
