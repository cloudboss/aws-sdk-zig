/// Contains information about the data store that you manage.
pub const CustomerManagedDatastoreS3StorageSummary = struct {
    /// The name of the Amazon S3 bucket where your data is stored.
    bucket: ?[]const u8,

    /// (Optional) The prefix used to create the keys of the data store data
    /// objects. Each object in an Amazon S3 bucket has a key that is its unique
    /// identifier in the bucket. Each object in a bucket has exactly one key. The
    /// prefix must end with a forward slash (/).
    key_prefix: ?[]const u8,

    /// The ARN of the role that grants IoT Analytics permission to interact with
    /// your Amazon S3 resources.
    role_arn: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key_prefix = "keyPrefix",
        .role_arn = "roleArn",
    };
};
