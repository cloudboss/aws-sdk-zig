const FlywheelStatus = @import("flywheel_status.zig").FlywheelStatus;

/// Filter the flywheels based on creation time or flywheel status.
pub const FlywheelFilter = struct {
    /// Filter the flywheels to include flywheels created after the specified time.
    creation_time_after: ?i64 = null,

    /// Filter the flywheels to include flywheels created before the specified time.
    creation_time_before: ?i64 = null,

    /// Filter the flywheels based on the flywheel status.
    status: ?FlywheelStatus = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .status = "Status",
    };
};
