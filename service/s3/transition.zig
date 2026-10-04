const TransitionStorageClass = @import("transition_storage_class.zig").TransitionStorageClass;

/// Specifies when an object transitions to a specified storage class. For more
/// information about Amazon S3
/// lifecycle configuration rules, see [Transitioning Objects Using
/// Amazon S3
/// Lifecycle](https://docs.aws.amazon.com/AmazonS3/latest/dev/lifecycle-transition-general-considerations.html) in the *Amazon S3 User Guide*.
pub const Transition = struct {
    /// Indicates when objects are transitioned to the specified storage class. The
    /// date value must be in
    /// ISO 8601 format. The time is always midnight UTC.
    date: ?i64 = null,

    /// Indicates the number of days after creation when objects are transitioned to
    /// the specified storage
    /// class. The value can be `0` or any positive integer. Be aware that some
    /// storage classes have a
    /// minimum storage duration and that you're charged for transitioning objects
    /// before their minimum storage
    /// duration. For more information, see [ Constraints and considerations for
    /// transitions](https://docs.aws.amazon.com/AmazonS3/latest/userguide/lifecycle-transition-general-considerations.html#lifecycle-configuration-constraints) in the *Amazon S3 User
    /// Guide*.
    days: ?i32 = null,

    /// The storage class to which you want the object to transition.
    storage_class: ?TransitionStorageClass = null,
};
