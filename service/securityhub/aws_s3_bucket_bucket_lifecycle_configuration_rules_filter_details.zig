const AwsS3BucketBucketLifecycleConfigurationRulesFilterPredicateDetails = @import("aws_s3_bucket_bucket_lifecycle_configuration_rules_filter_predicate_details.zig").AwsS3BucketBucketLifecycleConfigurationRulesFilterPredicateDetails;

/// Identifies the objects that a rule applies to.
pub const AwsS3BucketBucketLifecycleConfigurationRulesFilterDetails = struct {
    /// The configuration for the filter.
    predicate: ?AwsS3BucketBucketLifecycleConfigurationRulesFilterPredicateDetails,

    pub const json_field_names = .{
        .predicate = "Predicate",
    };
};
