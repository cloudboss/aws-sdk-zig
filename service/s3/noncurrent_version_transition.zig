const TransitionStorageClass = @import("transition_storage_class.zig").TransitionStorageClass;

/// Container for the transition rule that describes when noncurrent objects
/// transition to the
/// `STANDARD_IA`, `ONEZONE_IA`, `INTELLIGENT_TIERING`,
/// `GLACIER_IR`, `GLACIER`, or `DEEP_ARCHIVE` storage class. If your
/// bucket is versioning-enabled (or versioning is suspended), you can set this
/// action to request that Amazon S3
/// transition noncurrent object versions to the `STANDARD_IA`, `ONEZONE_IA`,
/// `INTELLIGENT_TIERING`, `GLACIER_IR`, `GLACIER`, or
/// `DEEP_ARCHIVE` storage class at a specific period in the object's lifetime.
pub const NoncurrentVersionTransition = struct {
    /// Specifies how many noncurrent versions Amazon S3 will retain in the same
    /// storage class before
    /// transitioning objects. You can specify up to 100 noncurrent versions to
    /// retain. Amazon S3 will transition any
    /// additional noncurrent versions beyond the specified number to retain. For
    /// more information about
    /// noncurrent versions, see [Lifecycle configuration
    /// elements](https://docs.aws.amazon.com/AmazonS3/latest/userguide/intro-lifecycle-rules.html) in
    /// the *Amazon S3 User Guide*.
    newer_noncurrent_versions: ?i32,

    /// Specifies the number of days an object is noncurrent before Amazon S3 can
    /// perform the associated action.
    /// For information about the noncurrent days calculations, see [How Amazon S3
    /// Calculates
    /// How Long an Object Has Been
    /// Noncurrent](https://docs.aws.amazon.com/AmazonS3/latest/dev/intro-lifecycle-rules.html#non-current-days-calculations) in the *Amazon S3 User Guide*.
    noncurrent_days: ?i32,

    /// The class of storage used to store the object.
    storage_class: ?TransitionStorageClass,
};
