/// Contains information on the current bucket policies for the S3 bucket.
pub const BucketPolicy = struct {
    /// A value that indicates whether public read access for the bucket is enabled
    /// through a
    /// bucket policy.
    allows_public_read_access: ?bool,

    /// A value that indicates whether public write access for the bucket is enabled
    /// through a
    /// bucket policy.
    allows_public_write_access: ?bool,

    pub const json_field_names = .{
        .allows_public_read_access = "AllowsPublicReadAccess",
        .allows_public_write_access = "AllowsPublicWriteAccess",
    };
};
