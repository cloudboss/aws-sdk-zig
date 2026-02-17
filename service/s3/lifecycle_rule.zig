const AbortIncompleteMultipartUpload = @import("abort_incomplete_multipart_upload.zig").AbortIncompleteMultipartUpload;
const LifecycleExpiration = @import("lifecycle_expiration.zig").LifecycleExpiration;
const LifecycleRuleFilter = @import("lifecycle_rule_filter.zig").LifecycleRuleFilter;
const NoncurrentVersionExpiration = @import("noncurrent_version_expiration.zig").NoncurrentVersionExpiration;
const NoncurrentVersionTransition = @import("noncurrent_version_transition.zig").NoncurrentVersionTransition;
const ExpirationStatus = @import("expiration_status.zig").ExpirationStatus;
const Transition = @import("transition.zig").Transition;

/// A lifecycle rule for individual objects in an Amazon S3 bucket.
///
/// For more information see, [Managing your storage
/// lifecycle](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lifecycle-mgmt.html) in
/// the *Amazon S3 User Guide*.
pub const LifecycleRule = struct {
    abort_incomplete_multipart_upload: ?AbortIncompleteMultipartUpload,

    /// Specifies the expiration for the lifecycle of the object in the form of
    /// date, days and, whether the
    /// object has a delete marker.
    expiration: ?LifecycleExpiration,

    /// The `Filter` is used to identify objects that a Lifecycle Rule applies to. A
    /// `Filter` must have exactly one of `Prefix`, `Tag`,
    /// `ObjectSizeGreaterThan`, `ObjectSizeLessThan`, or `And` specified.
    /// `Filter` is required if the `LifecycleRule` does not contain a
    /// `Prefix` element.
    ///
    /// For more information about `Tag` filters, see [Adding filters to Lifecycle
    /// rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/intro-lifecycle-filters.html)
    /// in the *Amazon S3 User Guide*.
    ///
    /// `Tag` filters are not supported for directory buckets.
    filter: ?LifecycleRuleFilter,

    /// Unique identifier for the rule. The value cannot be longer than 255
    /// characters.
    id: ?[]const u8,

    noncurrent_version_expiration: ?NoncurrentVersionExpiration,

    /// Specifies the transition rule for the lifecycle rule that describes when
    /// noncurrent objects
    /// transition to a specific storage class. If your bucket is versioning-enabled
    /// (or versioning is
    /// suspended), you can set this action to request that Amazon S3 transition
    /// noncurrent object versions to a
    /// specific storage class at a set period in the object's lifetime.
    ///
    /// This parameter applies to general purpose buckets only. It is not supported
    /// for directory bucket
    /// lifecycle configurations.
    noncurrent_version_transitions: ?[]const NoncurrentVersionTransition,

    /// The general purpose bucket prefix that identifies one or more objects to
    /// which the rule applies. We recommend using `Filter` instead of `Prefix` for
    /// new PUTs. Previous configurations where a prefix is defined will continue to
    /// operate as before.
    ///
    /// Replacement must be made for object keys containing special characters (such
    /// as carriage returns) when using
    /// XML requests. For more information, see [
    /// XML related object key
    /// constraints](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-xml-related-constraints).
    prefix: ?[]const u8,

    /// If 'Enabled', the rule is currently being applied. If 'Disabled', the rule
    /// is not currently being
    /// applied.
    status: ExpirationStatus,

    /// Specifies when an Amazon S3 object transitions to a specified storage class.
    ///
    /// This parameter applies to general purpose buckets only. It is not supported
    /// for directory bucket
    /// lifecycle configurations.
    transitions: ?[]const Transition,
};
