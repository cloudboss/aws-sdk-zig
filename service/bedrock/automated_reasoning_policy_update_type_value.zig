/// Represents a modification to a value within an existing custom type.
pub const AutomatedReasoningPolicyUpdateTypeValue = struct {
    /// The new description for the type value, replacing the previous description.
    description: ?[]const u8,

    /// The new identifier or name for the type value, if you want to rename it.
    new_value: ?[]const u8,

    /// The current identifier or name of the type value to update.
    value: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .new_value = "newValue",
        .value = "value",
    };
};
