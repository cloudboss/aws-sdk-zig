const UpdateS3BucketResource = @import("update_s3_bucket_resource.zig").UpdateS3BucketResource;

/// Information about the protected resource
/// that is associated with the created Malware Protection plan.
/// Presently, `S3Bucket` is the only supported protected resource.
pub const UpdateProtectedResource = struct {
    /// Information about the protected S3 bucket resource.
    s3_bucket: ?UpdateS3BucketResource = null,

    pub const json_field_names = .{
        .s3_bucket = "S3Bucket",
    };
};
