pub const UnlockState = enum {
    unlocked,
    locked,
    unlocking,

    pub const json_field_names = .{
        .unlocked = "UNLOCKED",
        .locked = "LOCKED",
        .unlocking = "UNLOCKING",
    };
};
