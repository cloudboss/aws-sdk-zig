const JobComparator = @import("job_comparator.zig").JobComparator;
const SimpleCriterionKeyForJob = @import("simple_criterion_key_for_job.zig").SimpleCriterionKeyForJob;

/// Specifies a property-based condition that determines whether an S3 bucket is
/// included or excluded from a classification job.
pub const SimpleCriterionForJob = struct {
    /// The operator to use in the condition. Valid values are EQ (equals) and NE
    /// (not equals).
    comparator: ?JobComparator = null,

    /// The property to use in the condition.
    key: ?SimpleCriterionKeyForJob = null,

    /// An array that lists one or more values to use in the condition. If you
    /// specify multiple values, Amazon Macie uses OR logic to join the values.
    /// Valid values for each supported property (key) are:
    ///
    /// * ACCOUNT_ID - A string that represents the unique identifier for the Amazon
    ///   Web Services account that owns the bucket.
    /// * S3_BUCKET_EFFECTIVE_PERMISSION - A string that represents an enumerated
    ///   value that Macie defines for the
    ///   [BucketPublicAccess.effectivePermission](https://docs.aws.amazon.com/macie/latest/APIReference/datasources-s3.html#datasources-s3-prop-bucketpublicaccess-effectivepermission) property of a bucket.
    /// * S3_BUCKET_NAME - A string that represents the name of a bucket.
    /// * S3_BUCKET_SHARED_ACCESS - A string that represents an enumerated value
    ///   that Macie defines for the
    ///   [BucketMetadata.sharedAccess](https://docs.aws.amazon.com/macie/latest/APIReference/datasources-s3.html#datasources-s3-prop-bucketmetadata-sharedaccess) property of a bucket.
    ///
    /// Values are case sensitive. Also, Macie doesn't support use of partial values
    /// or wildcard characters in these values.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .comparator = "comparator",
        .key = "key",
        .values = "values",
    };
};
