const AwsS3BucketBucketLifecycleConfigurationRulesDetails = @import("aws_s3_bucket_bucket_lifecycle_configuration_rules_details.zig").AwsS3BucketBucketLifecycleConfigurationRulesDetails;

/// The lifecycle configuration for the objects in the S3 bucket.
pub const AwsS3BucketBucketLifecycleConfigurationDetails = struct {
    /// The lifecycle rules.
    rules: ?[]const AwsS3BucketBucketLifecycleConfigurationRulesDetails,

    pub const json_field_names = .{
        .rules = "Rules",
    };
};
