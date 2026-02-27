const UnlockDelay = @import("unlock_delay.zig").UnlockDelay;

/// Information about a retention rule lock configuration.
pub const LockConfiguration = struct {
    /// Information about the retention rule unlock delay.
    unlock_delay: UnlockDelay,

    pub const json_field_names = .{
        .unlock_delay = "UnlockDelay",
    };
};
