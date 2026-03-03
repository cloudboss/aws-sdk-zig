/// The information required to update the S3 base location that holds the
/// application.
pub const S3ContentBaseLocationUpdate = struct {
    /// The updated S3 bucket path.
    base_path_update: ?[]const u8 = null,

    /// The updated Amazon Resource Name (ARN) of the S3 bucket.
    bucket_arn_update: ?[]const u8 = null,

    pub const json_field_names = .{
        .base_path_update = "BasePathUpdate",
        .bucket_arn_update = "BucketARNUpdate",
    };
};
