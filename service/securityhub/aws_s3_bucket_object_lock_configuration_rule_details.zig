const AwsS3BucketObjectLockConfigurationRuleDefaultRetentionDetails = @import("aws_s3_bucket_object_lock_configuration_rule_default_retention_details.zig").AwsS3BucketObjectLockConfigurationRuleDefaultRetentionDetails;

/// Specifies the S3 Object Lock rule for the specified object. In Amazon S3,
/// Object Lock can help prevent objects from being deleted or overwritten for a
/// fixed amount of time or indefinitely.
pub const AwsS3BucketObjectLockConfigurationRuleDetails = struct {
    /// The default Object Lock retention mode and period that you want to apply to
    /// new objects placed in the specified bucket.
    default_retention: ?AwsS3BucketObjectLockConfigurationRuleDefaultRetentionDetails,

    pub const json_field_names = .{
        .default_retention = "DefaultRetention",
    };
};
