pub const LockState = enum {
    locked,
    pending_unlock,
    unlocked,

    pub const json_field_names = .{
        .locked = "LOCKED",
        .pending_unlock = "PENDING_UNLOCK",
        .unlocked = "UNLOCKED",
    };
};
