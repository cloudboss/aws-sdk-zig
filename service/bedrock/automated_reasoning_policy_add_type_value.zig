/// Represents a single value that can be added to an existing custom type in
/// the policy.
pub const AutomatedReasoningPolicyAddTypeValue = struct {
    /// A description of what this new type value represents and when it should be
    /// used.
    description: ?[]const u8,

    /// The identifier or name of the new value to add to the type.
    value: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .value = "value",
    };
};
