const SearchResourcesComparator = @import("search_resources_comparator.zig").SearchResourcesComparator;
const SearchResourcesSimpleCriterionKey = @import("search_resources_simple_criterion_key.zig").SearchResourcesSimpleCriterionKey;

/// Specifies a property-based filter condition that determines which Amazon Web
/// Services resources are included or excluded from the query results.
pub const SearchResourcesSimpleCriterion = struct {
    /// The operator to use in the condition. Valid values are EQ (equals) and NE
    /// (not equals).
    comparator: ?SearchResourcesComparator,

    /// The property to use in the condition.
    key: ?SearchResourcesSimpleCriterionKey,

    /// An array that lists one or more values to use in the condition. If you
    /// specify multiple values, Amazon Macie uses OR logic to join the values.
    /// Valid values for each supported property (key) are:
    ///
    /// * ACCOUNT_ID - A string that represents the unique identifier for the Amazon
    ///   Web Services account that owns the resource.
    /// * AUTOMATED_DISCOVERY_MONITORING_STATUS - A string that represents an
    ///   enumerated value that Macie defines for the
    ///   [BucketMetadata.automatedDiscoveryMonitoringStatus](https://docs.aws.amazon.com/macie/latest/APIReference/datasources-s3.html#datasources-s3-prop-bucketmetadata-automateddiscoverymonitoringstatus) property of an S3 bucket.
    /// * S3_BUCKET_EFFECTIVE_PERMISSION - A string that represents an enumerated
    ///   value that Macie defines for the
    ///   [BucketPublicAccess.effectivePermission](https://docs.aws.amazon.com/macie/latest/APIReference/datasources-s3.html#datasources-s3-prop-bucketpublicaccess-effectivepermission) property of an S3 bucket.
    /// * S3_BUCKET_NAME - A string that represents the name of an S3 bucket.
    /// * S3_BUCKET_SHARED_ACCESS - A string that represents an enumerated value
    ///   that Macie defines for the
    ///   [BucketMetadata.sharedAccess](https://docs.aws.amazon.com/macie/latest/APIReference/datasources-s3.html#datasources-s3-prop-bucketmetadata-sharedaccess) property of an S3 bucket.
    ///
    /// Values are case sensitive. Also, Macie doesn't support use of partial values
    /// or wildcard characters in values.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .comparator = "comparator",
        .key = "key",
        .values = "values",
    };
};
