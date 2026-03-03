/// A storage location in an Amazon S3 bucket.
pub const S3Location = struct {
    /// If the bucket belongs to another AWS account, specify that account's ID.
    bucket_owner: ?[]const u8 = null,

    /// An object URI starting with `s3://`.
    uri: []const u8,

    pub const json_field_names = .{
        .bucket_owner = "bucketOwner",
        .uri = "uri",
    };
};
