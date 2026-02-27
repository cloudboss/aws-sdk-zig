/// Represents an Amazon S3 location (bucket name, bucket owner, and object key)
/// where DataBrew can read
/// input data, or write output from a job.
pub const S3Location = struct {
    /// The Amazon S3 bucket name.
    bucket: []const u8,

    /// The Amazon Web Services account ID of the bucket owner.
    bucket_owner: ?[]const u8,

    /// The unique name of the object in the bucket.
    key: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .bucket_owner = "BucketOwner",
        .key = "Key",
    };
};
