const AbortIncompleteMultipartUpload = @import("abort_incomplete_multipart_upload.zig").AbortIncompleteMultipartUpload;
const LifecycleExpiration = @import("lifecycle_expiration.zig").LifecycleExpiration;
const LifecycleRuleFilter = @import("lifecycle_rule_filter.zig").LifecycleRuleFilter;
const NoncurrentVersionExpiration = @import("noncurrent_version_expiration.zig").NoncurrentVersionExpiration;
const NoncurrentVersionTransition = @import("noncurrent_version_transition.zig").NoncurrentVersionTransition;
const ExpirationStatus = @import("expiration_status.zig").ExpirationStatus;
const Transition = @import("transition.zig").Transition;

/// The container for the Outposts bucket lifecycle rule.
pub const LifecycleRule = struct {
    /// Specifies the days since the initiation of an incomplete multipart upload
    /// that Amazon S3
    /// waits before permanently removing all parts of the upload. For more
    /// information, see [
    /// Aborting Incomplete Multipart Uploads Using a Bucket Lifecycle
    /// Configuration](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config) in
    /// the *Amazon S3 User Guide*.
    abort_incomplete_multipart_upload: ?AbortIncompleteMultipartUpload = null,

    /// Specifies the expiration for the lifecycle of the object in the form of
    /// date, days and,
    /// whether the object has a delete marker.
    expiration: ?LifecycleExpiration = null,

    /// The container for the filter of lifecycle rule.
    filter: ?LifecycleRuleFilter = null,

    /// Unique identifier for the rule. The value cannot be longer than 255
    /// characters.
    id: ?[]const u8 = null,

    /// The noncurrent version expiration of the lifecycle rule.
    noncurrent_version_expiration: ?NoncurrentVersionExpiration = null,

    /// Specifies the transition rule for the lifecycle rule that describes when
    /// noncurrent
    /// objects transition to a specific storage class. If your bucket is
    /// versioning-enabled (or
    /// versioning is suspended), you can set this action to request that Amazon S3
    /// transition
    /// noncurrent object versions to a specific storage class at a set period in
    /// the object's
    /// lifetime.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    noncurrent_version_transitions: ?[]const NoncurrentVersionTransition = null,

    /// If 'Enabled', the rule is currently being applied. If 'Disabled', the rule
    /// is not
    /// currently being applied.
    status: ExpirationStatus,

    /// Specifies when an Amazon S3 object transitions to a specified storage class.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    transitions: ?[]const Transition = null,
};
