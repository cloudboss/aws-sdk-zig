const SafetyLeverStatus = @import("safety_lever_status.zig").SafetyLeverStatus;

/// Describes the state of the safety lever.
pub const SafetyLeverState = struct {
    /// The reason for the state of the safety lever.
    reason: ?[]const u8,

    /// The state of the safety lever.
    status: ?SafetyLeverStatus,

    pub const json_field_names = .{
        .reason = "reason",
        .status = "status",
    };
};
