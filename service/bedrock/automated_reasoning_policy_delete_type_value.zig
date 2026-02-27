/// Represents a value to be removed from an existing custom type in the policy.
pub const AutomatedReasoningPolicyDeleteTypeValue = struct {
    /// The identifier or name of the value to remove from the type.
    value: []const u8,

    pub const json_field_names = .{
        .value = "value",
    };
};
