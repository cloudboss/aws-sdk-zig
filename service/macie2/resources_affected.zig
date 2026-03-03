const S3Bucket = @import("s3_bucket.zig").S3Bucket;
const S3Object = @import("s3_object.zig").S3Object;

/// Provides information about the resources that a finding applies to.
pub const ResourcesAffected = struct {
    /// The details of the S3 bucket that the finding applies to.
    s_3_bucket: ?S3Bucket = null,

    /// The details of the S3 object that the finding applies to.
    s_3_object: ?S3Object = null,

    pub const json_field_names = .{
        .s_3_bucket = "s3Bucket",
        .s_3_object = "s3Object",
    };
};
