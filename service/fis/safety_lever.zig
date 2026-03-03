const SafetyLeverState = @import("safety_lever_state.zig").SafetyLeverState;

/// Describes a safety lever.
pub const SafetyLever = struct {
    /// The Amazon Resource Name (ARN) of the safety lever.
    arn: ?[]const u8 = null,

    /// The ID of the safety lever.
    id: ?[]const u8 = null,

    /// The state of the safety lever.
    state: ?SafetyLeverState = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .state = "state",
    };
};
