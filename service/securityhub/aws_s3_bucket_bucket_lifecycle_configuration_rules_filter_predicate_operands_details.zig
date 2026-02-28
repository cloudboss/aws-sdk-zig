const AwsS3BucketBucketLifecycleConfigurationRulesFilterPredicateOperandsTagDetails = @import("aws_s3_bucket_bucket_lifecycle_configuration_rules_filter_predicate_operands_tag_details.zig").AwsS3BucketBucketLifecycleConfigurationRulesFilterPredicateOperandsTagDetails;

/// A value to use for the filter.
pub const AwsS3BucketBucketLifecycleConfigurationRulesFilterPredicateOperandsDetails = struct {
    /// Prefix text for matching objects.
    prefix: ?[]const u8,

    /// A tag that is assigned to matching objects.
    tag: ?AwsS3BucketBucketLifecycleConfigurationRulesFilterPredicateOperandsTagDetails,

    /// The type of filter value.
    /// Valid values are `LifecyclePrefixPredicate` or `LifecycleTagPredicate`.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .prefix = "Prefix",
        .tag = "Tag",
        .@"type" = "Type",
    };
};
