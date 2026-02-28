const AwsS3BucketBucketLifecycleConfigurationRulesFilterPredicateOperandsDetails = @import("aws_s3_bucket_bucket_lifecycle_configuration_rules_filter_predicate_operands_details.zig").AwsS3BucketBucketLifecycleConfigurationRulesFilterPredicateOperandsDetails;
const AwsS3BucketBucketLifecycleConfigurationRulesFilterPredicateTagDetails = @import("aws_s3_bucket_bucket_lifecycle_configuration_rules_filter_predicate_tag_details.zig").AwsS3BucketBucketLifecycleConfigurationRulesFilterPredicateTagDetails;

/// The configuration for the filter.
pub const AwsS3BucketBucketLifecycleConfigurationRulesFilterPredicateDetails = struct {
    /// The values to use for the filter.
    operands: ?[]const AwsS3BucketBucketLifecycleConfigurationRulesFilterPredicateOperandsDetails,

    /// A prefix filter.
    prefix: ?[]const u8,

    /// A tag filter.
    tag: ?AwsS3BucketBucketLifecycleConfigurationRulesFilterPredicateTagDetails,

    /// Whether to use `AND` or `OR` to join the operands.
    /// Valid values are `LifecycleAndOperator` or `LifecycleOrOperator`.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .operands = "Operands",
        .prefix = "Prefix",
        .tag = "Tag",
        .@"type" = "Type",
    };
};
