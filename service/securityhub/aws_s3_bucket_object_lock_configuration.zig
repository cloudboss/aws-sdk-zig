const AwsS3BucketObjectLockConfigurationRuleDetails = @import("aws_s3_bucket_object_lock_configuration_rule_details.zig").AwsS3BucketObjectLockConfigurationRuleDetails;

/// The container element for S3 Object Lock configuration parameters. In Amazon
/// S3, Object Lock can help prevent objects from being deleted or overwritten
/// for a fixed amount of time or indefinitely.
pub const AwsS3BucketObjectLockConfiguration = struct {
    /// Indicates whether the bucket has an Object Lock configuration enabled.
    object_lock_enabled: ?[]const u8 = null,

    /// Specifies the Object Lock rule for the specified object.
    rule: ?AwsS3BucketObjectLockConfigurationRuleDetails = null,

    pub const json_field_names = .{
        .object_lock_enabled = "ObjectLockEnabled",
        .rule = "Rule",
    };
};
