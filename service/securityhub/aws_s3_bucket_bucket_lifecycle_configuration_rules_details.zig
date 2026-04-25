const AwsS3BucketBucketLifecycleConfigurationRulesAbortIncompleteMultipartUploadDetails = @import("aws_s3_bucket_bucket_lifecycle_configuration_rules_abort_incomplete_multipart_upload_details.zig").AwsS3BucketBucketLifecycleConfigurationRulesAbortIncompleteMultipartUploadDetails;
const AwsS3BucketBucketLifecycleConfigurationRulesFilterDetails = @import("aws_s3_bucket_bucket_lifecycle_configuration_rules_filter_details.zig").AwsS3BucketBucketLifecycleConfigurationRulesFilterDetails;
const AwsS3BucketBucketLifecycleConfigurationRulesNoncurrentVersionTransitionsDetails = @import("aws_s3_bucket_bucket_lifecycle_configuration_rules_noncurrent_version_transitions_details.zig").AwsS3BucketBucketLifecycleConfigurationRulesNoncurrentVersionTransitionsDetails;
const AwsS3BucketBucketLifecycleConfigurationRulesTransitionsDetails = @import("aws_s3_bucket_bucket_lifecycle_configuration_rules_transitions_details.zig").AwsS3BucketBucketLifecycleConfigurationRulesTransitionsDetails;

/// Configuration for a lifecycle rule.
pub const AwsS3BucketBucketLifecycleConfigurationRulesDetails = struct {
    /// How Amazon S3 responds when a multipart upload is incomplete. Specifically,
    /// provides a number
    /// of days before Amazon S3 cancels the entire upload.
    abort_incomplete_multipart_upload: ?AwsS3BucketBucketLifecycleConfigurationRulesAbortIncompleteMultipartUploadDetails = null,

    /// The date when objects are moved or deleted.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    expiration_date: ?[]const u8 = null,

    /// The length in days of the lifetime for objects that are subject to the rule.
    expiration_in_days: ?i32 = null,

    /// Whether Amazon S3 removes a delete marker that has no noncurrent versions.
    /// If set to
    /// `true`, the delete marker is expired. If set to `false`, the policy
    /// takes no action.
    ///
    /// If you provide `ExpiredObjectDeleteMarker`, you cannot provide
    /// `ExpirationInDays` or `ExpirationDate`.
    expired_object_delete_marker: ?bool = null,

    /// Identifies the objects that a rule applies to.
    filter: ?AwsS3BucketBucketLifecycleConfigurationRulesFilterDetails = null,

    /// The unique identifier of the rule.
    id: ?[]const u8 = null,

    /// The number of days that an object is noncurrent before Amazon S3 can perform
    /// the associated action.
    noncurrent_version_expiration_in_days: ?i32 = null,

    /// Transition rules that describe when noncurrent objects transition to a
    /// specified storage class.
    noncurrent_version_transitions: ?[]const AwsS3BucketBucketLifecycleConfigurationRulesNoncurrentVersionTransitionsDetails = null,

    /// A prefix that identifies one or more objects that the rule applies to.
    prefix: ?[]const u8 = null,

    /// The current status of the rule. Indicates whether the rule is currently
    /// being applied.
    status: ?[]const u8 = null,

    /// Transition rules that indicate when objects transition to a specified
    /// storage class.
    transitions: ?[]const AwsS3BucketBucketLifecycleConfigurationRulesTransitionsDetails = null,

    pub const json_field_names = .{
        .abort_incomplete_multipart_upload = "AbortIncompleteMultipartUpload",
        .expiration_date = "ExpirationDate",
        .expiration_in_days = "ExpirationInDays",
        .expired_object_delete_marker = "ExpiredObjectDeleteMarker",
        .filter = "Filter",
        .id = "ID",
        .noncurrent_version_expiration_in_days = "NoncurrentVersionExpirationInDays",
        .noncurrent_version_transitions = "NoncurrentVersionTransitions",
        .prefix = "Prefix",
        .status = "Status",
        .transitions = "Transitions",
    };
};
