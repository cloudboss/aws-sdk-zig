/// Represents a single value within a custom type definition, including its
/// identifier and description.
pub const AutomatedReasoningPolicyDefinitionTypeValue = struct {
    /// A human-readable description explaining what this type value represents and
    /// when it should be used.
    description: ?[]const u8 = null,

    /// The actual value or identifier for this type value.
    value: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .value = "value",
    };
};
