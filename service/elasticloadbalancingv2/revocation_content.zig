const RevocationType = @import("revocation_type.zig").RevocationType;

/// Information about a revocation file.
pub const RevocationContent = struct {
    /// The type of revocation file.
    revocation_type: ?RevocationType = null,

    /// The Amazon S3 bucket for the revocation file.
    s3_bucket: ?[]const u8 = null,

    /// The Amazon S3 path for the revocation file.
    s3_key: ?[]const u8 = null,

    /// The Amazon S3 object version of the revocation file.
    s3_object_version: ?[]const u8 = null,
};
