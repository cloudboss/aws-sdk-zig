/// Provides information about the permissions settings of the bucket policy for
/// an S3 bucket.
pub const BucketPolicy = struct {
    /// Specifies whether the bucket policy allows the general public to have read
    /// access to the bucket.
    allows_public_read_access: ?bool = null,

    /// Specifies whether the bucket policy allows the general public to have write
    /// access to the bucket.
    allows_public_write_access: ?bool = null,

    pub const json_field_names = .{
        .allows_public_read_access = "allowsPublicReadAccess",
        .allows_public_write_access = "allowsPublicWriteAccess",
    };
};
