const SafetyLeverStatusInput = @import("safety_lever_status_input.zig").SafetyLeverStatusInput;

/// Specifies a state for a safety lever.
pub const UpdateSafetyLeverStateInput = struct {
    /// The reason for updating the state of the safety lever.
    reason: []const u8,

    /// The updated state of the safety lever.
    status: SafetyLeverStatusInput,

    pub const json_field_names = .{
        .reason = "reason",
        .status = "status",
    };
};
