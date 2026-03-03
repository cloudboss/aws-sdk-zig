const ObjectLockEnabled = @import("object_lock_enabled.zig").ObjectLockEnabled;
const ObjectLockRule = @import("object_lock_rule.zig").ObjectLockRule;

/// The container element for Object Lock configuration parameters.
pub const ObjectLockConfiguration = struct {
    /// Indicates whether this bucket has an Object Lock configuration enabled.
    /// Enable
    /// `ObjectLockEnabled` when you apply `ObjectLockConfiguration` to a bucket.
    object_lock_enabled: ?ObjectLockEnabled = null,

    /// Specifies the Object Lock rule for the specified object. Enable the this
    /// rule when you apply
    /// `ObjectLockConfiguration` to a bucket. Bucket settings require both a mode
    /// and a period.
    /// The period can be either `Days` or `Years` but you must select one. You
    /// cannot
    /// specify `Days` and `Years` at the same time.
    rule: ?ObjectLockRule = null,
};
