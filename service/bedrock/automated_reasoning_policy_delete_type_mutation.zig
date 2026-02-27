/// A mutation operation that removes a custom type from the policy definition
/// during the build process.
pub const AutomatedReasoningPolicyDeleteTypeMutation = struct {
    /// The name of the custom type to delete.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
