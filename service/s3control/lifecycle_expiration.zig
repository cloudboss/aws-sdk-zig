/// The container of the Outposts bucket lifecycle expiration.
pub const LifecycleExpiration = struct {
    /// Indicates at what date the object is to be deleted. Should be in GMT ISO
    /// 8601
    /// format.
    date: ?i64,

    /// Indicates the lifetime, in days, of the objects that are subject to the
    /// rule. The value
    /// must be a non-zero positive integer.
    days: i32 = 0,

    /// Indicates whether Amazon S3 will remove a delete marker with no noncurrent
    /// versions. If set
    /// to true, the delete marker will be expired. If set to false, the policy
    /// takes no action.
    /// This cannot be specified with Days or Date in a Lifecycle Expiration Policy.
    /// To learn more about delete markers, see [Working with delete
    /// markers](https://docs.aws.amazon.com/AmazonS3/latest/userguide/DeleteMarker.html).
    expired_object_delete_marker: bool = false,
};
