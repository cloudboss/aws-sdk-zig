/// A user input field in an plugin action execution payload.
pub const ActionExecutionPayloadField = struct {
    /// The content of a user input field in an plugin action execution payload.
    value: []const u8,

    pub const json_field_names = .{
        .value = "value",
    };
};
