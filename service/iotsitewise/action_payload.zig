/// The JSON payload of the action.
pub const ActionPayload = struct {
    /// The payload of the action in a JSON string.
    string_value: []const u8,

    pub const json_field_names = .{
        .string_value = "stringValue",
    };
};
