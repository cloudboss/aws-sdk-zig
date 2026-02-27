/// Configuration parameters for where in an S3 bucket to place the harvested
/// content
pub const S3Destination = struct {
    /// The name of an S3 bucket within which harvested content will be exported
    bucket_name: []const u8,

    /// The key in the specified S3 bucket where the harvested top-level manifest
    /// will be placed.
    manifest_key: []const u8,

    /// The IAM role used to write to the specified S3 bucket
    role_arn: []const u8,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .manifest_key = "ManifestKey",
        .role_arn = "RoleArn",
    };
};
