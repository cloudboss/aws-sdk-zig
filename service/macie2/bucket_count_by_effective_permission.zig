/// Provides information about the number of S3 buckets that are publicly
/// accessible due to a combination of permissions settings for each bucket.
pub const BucketCountByEffectivePermission = struct {
    /// The total number of buckets that allow the general public to have read or
    /// write access to the bucket.
    publicly_accessible: ?i64,

    /// The total number of buckets that allow the general public to have read
    /// access to the bucket.
    publicly_readable: ?i64,

    /// The total number of buckets that allow the general public to have write
    /// access to the bucket.
    publicly_writable: ?i64,

    /// The total number of buckets that Amazon Macie wasn't able to evaluate
    /// permissions settings for. For example, the buckets' policies or a quota
    /// prevented Macie from retrieving the requisite data. Macie can't determine
    /// whether the buckets are publicly accessible.
    unknown: ?i64,

    pub const json_field_names = .{
        .publicly_accessible = "publiclyAccessible",
        .publicly_readable = "publiclyReadable",
        .publicly_writable = "publiclyWritable",
        .unknown = "unknown",
    };
};
