const CreateS3BucketResource = @import("create_s3_bucket_resource.zig").CreateS3BucketResource;

/// Information about the protected resource that
/// is associated with the created Malware Protection plan.
/// Presently, `S3Bucket` is the only supported
/// protected resource.
pub const CreateProtectedResource = struct {
    /// Information about the protected S3 bucket resource.
    s3_bucket: ?CreateS3BucketResource,

    pub const json_field_names = .{
        .s3_bucket = "S3Bucket",
    };
};
