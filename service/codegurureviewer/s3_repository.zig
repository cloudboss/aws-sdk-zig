/// Information about a repository in an S3 bucket.
pub const S3Repository = struct {
    /// The name of the S3 bucket used for associating a new S3 repository. It must
    /// begin with `codeguru-reviewer-`.
    bucket_name: []const u8,

    /// The name of the repository in the S3 bucket.
    name: []const u8,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .name = "Name",
    };
};
