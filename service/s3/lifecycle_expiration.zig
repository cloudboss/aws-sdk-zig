/// Container for the expiration for the lifecycle of the object.
///
/// For more information see, [Managing your storage
/// lifecycle](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lifecycle-mgmt.html) in
/// the *Amazon S3 User Guide*.
pub const LifecycleExpiration = struct {
    /// Indicates at what date the object is to be moved or deleted. The date value
    /// must conform to the ISO
    /// 8601 format. The time is always midnight UTC.
    ///
    /// This parameter applies to general purpose buckets only. It is not supported
    /// for directory bucket
    /// lifecycle configurations.
    date: ?i64 = null,

    /// Indicates the lifetime, in days, of the objects that are subject to the
    /// rule. The value must be a
    /// non-zero positive integer.
    days: ?i32 = null,

    /// Indicates whether Amazon S3 will remove a delete marker with no noncurrent
    /// versions. If set to true, the
    /// delete marker will be expired; if set to false the policy takes no action.
    /// This cannot be specified with
    /// Days or Date in a Lifecycle Expiration Policy.
    ///
    /// This parameter applies to general purpose buckets only. It is not supported
    /// for directory bucket
    /// lifecycle configurations.
    expired_object_delete_marker: ?bool = null,
};
