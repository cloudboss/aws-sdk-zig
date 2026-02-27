const UpdateSafetyLeverStateInput = @import("update_safety_lever_state_input.zig").UpdateSafetyLeverStateInput;

pub const UpdateSafetyLeverStateRequest = struct {
    /// The ID of the safety lever.
    id: []const u8,

    /// The state of the safety lever.
    state: UpdateSafetyLeverStateInput,

    pub const json_field_names = .{
        .id = "id",
        .state = "state",
    };
};
