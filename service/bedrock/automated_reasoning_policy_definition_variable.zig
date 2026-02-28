/// Represents a variable in an Automated Reasoning policy. Variables represent
/// concepts that can have values assigned during natural language translation.
pub const AutomatedReasoningPolicyDefinitionVariable = struct {
    /// The description of the variable that explains what it represents and how
    /// users might refer to it. Clear and comprehensive descriptions are essential
    /// for accurate natural language translation.
    description: []const u8,

    /// The name of the variable. Use descriptive names that clearly indicate the
    /// concept being represented.
    name: []const u8,

    /// The data type of the variable. Valid types include bool, int, real, enum,
    /// and custom types that you can provide.
    type: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .type = "type",
    };
};
