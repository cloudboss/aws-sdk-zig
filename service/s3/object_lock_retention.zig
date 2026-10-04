const ObjectLockEventHold = @import("object_lock_event_hold.zig").ObjectLockEventHold;
const EventHoldDuration = @import("event_hold_duration.zig").EventHoldDuration;
const ObjectLockRetentionMode = @import("object_lock_retention_mode.zig").ObjectLockRetentionMode;

/// A Retention configuration for an object.
pub const ObjectLockRetention = struct {
    /// The event hold status for the object. Set to `ON` to enable an event hold or
    /// `OFF` to disable it.
    event_hold: ?ObjectLockEventHold = null,

    /// The event hold duration for the object. Specifies how long the object
    /// remains protected after the
    /// event hold is released.
    event_hold_duration: ?EventHoldDuration = null,

    /// Indicates the Retention mode for the specified object.
    mode: ?ObjectLockRetentionMode = null,

    /// The date on which this Object Lock Retention will expire.
    retain_until_date: ?i64 = null,
};
