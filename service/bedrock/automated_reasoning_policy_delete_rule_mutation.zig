/// A mutation operation that removes a rule from the policy definition during
/// the build process.
pub const AutomatedReasoningPolicyDeleteRuleMutation = struct {
    /// The unique identifier of the rule to delete.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};
