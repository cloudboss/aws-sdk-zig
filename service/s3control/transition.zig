const TransitionStorageClass = @import("transition_storage_class.zig").TransitionStorageClass;

/// Specifies when an object transitions to a specified storage class. For more
/// information
/// about Amazon S3 Lifecycle configuration rules, see [
/// Transitioning objects using Amazon S3
/// Lifecycle](https://docs.aws.amazon.com/AmazonS3/latest/dev/lifecycle-transition-general-considerations.html) in the
/// *Amazon S3 User Guide*.
pub const Transition = struct {
    /// Indicates when objects are transitioned to the specified storage class. The
    /// date value
    /// must be in ISO 8601 format. The time is always midnight UTC.
    date: ?i64 = null,

    /// Indicates the number of days after creation when objects are transitioned to
    /// the
    /// specified storage class. The value must be a positive integer.
    days: i32 = 0,

    /// The storage class to which you want the object to transition.
    storage_class: ?TransitionStorageClass = null,
};
