/// Contains information about an update to a static policy.
pub const UpdateStaticPolicyDefinition = struct {
    /// Specifies the description to be added to or replaced on the static policy.
    description: ?[]const u8,

    /// Specifies the Cedar policy language text to be added to or replaced on the
    /// static policy.
    ///
    /// You can change only the following elements from the original content:
    ///
    /// * The `action` referenced by the policy.
    /// * Any conditional clauses, such as `when` or `unless` clauses.
    ///
    /// You **can't** change the following elements:
    ///
    /// * Changing from `StaticPolicy` to `TemplateLinkedPolicy`.
    /// * The effect (`permit` or `forbid`) of the policy.
    /// * The `principal` referenced by the policy.
    /// * The `resource` referenced by the policy.
    statement: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .statement = "statement",
    };
};
