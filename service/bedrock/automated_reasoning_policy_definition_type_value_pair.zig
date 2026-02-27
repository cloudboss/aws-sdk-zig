/// Associates a type name with a specific value name, used for referencing type
/// values in rules and other policy elements.
pub const AutomatedReasoningPolicyDefinitionTypeValuePair = struct {
    /// The name of the custom type that contains the referenced value.
    type_name: []const u8,

    /// The name of the specific value within the type.
    value_name: []const u8,

    pub const json_field_names = .{
        .type_name = "typeName",
        .value_name = "valueName",
    };
};
