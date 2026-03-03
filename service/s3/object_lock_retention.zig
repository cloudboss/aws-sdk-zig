const ObjectLockRetentionMode = @import("object_lock_retention_mode.zig").ObjectLockRetentionMode;

/// A Retention configuration for an object.
pub const ObjectLockRetention = struct {
    /// Indicates the Retention mode for the specified object.
    mode: ?ObjectLockRetentionMode = null,

    /// The date on which this Object Lock Retention will expire.
    retain_until_date: ?i64 = null,
};
