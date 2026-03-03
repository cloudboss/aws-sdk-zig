/// Provides information about the total storage size (in bytes) or number of
/// objects that Amazon Macie can't analyze in one or more S3 buckets. In a
/// BucketMetadata or MatchingBucket object, this data is for a specific bucket.
/// In a GetBucketStatisticsResponse object, this data is aggregated for all the
/// buckets in the query results. If versioning is enabled for a bucket, storage
/// size values are based on the size of the latest version of each applicable
/// object in the bucket.
pub const ObjectLevelStatistics = struct {
    /// The total storage size (in bytes) or number of objects that Amazon Macie
    /// can't analyze because the objects don't have a file name extension for a
    /// supported file or storage format.
    file_type: ?i64 = null,

    /// The total storage size (in bytes) or number of objects that Amazon Macie
    /// can't analyze because the objects use an unsupported storage class.
    storage_class: ?i64 = null,

    /// The total storage size (in bytes) or number of objects that Amazon Macie
    /// can't analyze because the objects use an unsupported storage class or don't
    /// have a file name extension for a supported file or storage format.
    total: ?i64 = null,

    pub const json_field_names = .{
        .file_type = "fileType",
        .storage_class = "storageClass",
        .total = "total",
    };
};
