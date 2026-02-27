const UnlockDelayUnit = @import("unlock_delay_unit.zig").UnlockDelayUnit;

/// Information about the retention rule unlock delay. The unlock delay is the
/// period after which
/// a retention rule can be modified or edited after it has been unlocked by a
/// user with the required
/// permissions. The retention rule can't be modified or deleted during the
/// unlock delay.
pub const UnlockDelay = struct {
    /// The unit of time in which to measure the unlock delay. Currently, the unlock
    /// delay can
    /// be measured only in days.
    unlock_delay_unit: UnlockDelayUnit,

    /// The unlock delay period, measured in the unit specified for **
    /// UnlockDelayUnit**.
    unlock_delay_value: i32,

    pub const json_field_names = .{
        .unlock_delay_unit = "UnlockDelayUnit",
        .unlock_delay_value = "UnlockDelayValue",
    };
};
