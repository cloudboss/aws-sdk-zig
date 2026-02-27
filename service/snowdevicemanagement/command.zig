const Reboot = @import("reboot.zig").Reboot;
const Unlock = @import("unlock.zig").Unlock;

/// The command given to the device to execute.
pub const Command = union(enum) {
    /// Reboots the device.
    reboot: ?Reboot,
    /// Unlocks the device.
    unlock: ?Unlock,

    pub const json_field_names = .{
        .reboot = "reboot",
        .unlock = "unlock",
    };
};
