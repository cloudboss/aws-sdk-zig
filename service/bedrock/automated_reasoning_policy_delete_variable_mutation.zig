/// A mutation operation that removes a variable from the policy definition
/// during the build process.
pub const AutomatedReasoningPolicyDeleteVariableMutation = struct {
    /// The name of the variable to delete.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
