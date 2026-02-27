/// Provides aggregated statistical data for sensitive data discovery metrics
/// that apply to S3 buckets. Each field contains aggregated data for all the
/// buckets that have a sensitivity score (sensitivityScore) of a specified
/// value or within a specified range (BucketStatisticsBySensitivity). If
/// automated sensitive data discovery is currently disabled for your account,
/// the value for most fields is 0.
pub const SensitivityAggregations = struct {
    /// The total storage size, in bytes, of all the objects that Amazon Macie can
    /// analyze in the buckets. These objects use a supported storage class and have
    /// a file name extension for a supported file or storage format.
    ///
    /// If versioning is enabled for any of the buckets, this value is based on the
    /// size of the latest version of each applicable object in the buckets. This
    /// value doesn't reflect the storage size of all versions of all applicable
    /// objects in the buckets.
    classifiable_size_in_bytes: ?i64,

    /// The total number of buckets that are publicly accessible due to a
    /// combination of permissions settings for each bucket.
    publicly_accessible_count: ?i64,

    /// The total number of buckets.
    total_count: ?i64,

    /// The total storage size, in bytes, of the buckets.
    ///
    /// If versioning is enabled for any of the buckets, this value is based on the
    /// size of the latest version of each object in the buckets. This value doesn't
    /// reflect the storage size of all versions of the objects in the buckets.
    total_size_in_bytes: ?i64,

    pub const json_field_names = .{
        .classifiable_size_in_bytes = "classifiableSizeInBytes",
        .publicly_accessible_count = "publiclyAccessibleCount",
        .total_count = "totalCount",
        .total_size_in_bytes = "totalSizeInBytes",
    };
};
