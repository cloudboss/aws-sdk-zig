/// The job attachment settings returned to workers for a job. These are the
/// Amazon S3 bucket name and the Amazon S3 prefix.
pub const JobDetailsJobAttachmentSettings = struct {
    /// The root prefix.
    root_prefix: []const u8,

    /// The Amazon S3 bucket name.
    s_3_bucket_name: []const u8,

    pub const json_field_names = .{
        .root_prefix = "rootPrefix",
        .s_3_bucket_name = "s3BucketName",
    };
};
