/// Contains information about a variable in the prompt.
pub const PromptInputVariable = struct {
    /// The name of the variable.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
    };
};
