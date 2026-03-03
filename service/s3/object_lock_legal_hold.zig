const ObjectLockLegalHoldStatus = @import("object_lock_legal_hold_status.zig").ObjectLockLegalHoldStatus;

/// A legal hold configuration for an object.
pub const ObjectLockLegalHold = struct {
    /// Indicates whether the specified object has a legal hold in place.
    status: ?ObjectLockLegalHoldStatus = null,
};
