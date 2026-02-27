const TransitionStorageClass = @import("transition_storage_class.zig").TransitionStorageClass;

/// The container for the noncurrent version transition.
pub const NoncurrentVersionTransition = struct {
    /// Specifies the number of days an object is noncurrent before Amazon S3 can
    /// perform the
    /// associated action. For information about the noncurrent days calculations,
    /// see [ How
    /// Amazon S3 Calculates How Long an Object Has Been
    /// Noncurrent](https://docs.aws.amazon.com/AmazonS3/latest/dev/intro-lifecycle-rules.html#non-current-days-calculations) in the
    /// *Amazon S3 User Guide*.
    noncurrent_days: i32 = 0,

    /// The class of storage used to store the object.
    storage_class: ?TransitionStorageClass,
};
