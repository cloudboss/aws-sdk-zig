const CedarPolicy = @import("cedar_policy.zig").CedarPolicy;

/// Represents the definition structure for policies within the AgentCore Policy
/// system. This structure encapsulates different policy formats and languages
/// that can be used to define access control rules.
pub const PolicyDefinition = union(enum) {
    /// The Cedar policy definition within the policy definition structure. This
    /// contains the Cedar policy statement that defines the authorization logic
    /// using Cedar's human-readable, analyzable policy language. Cedar policies
    /// specify principals (who can access), actions (what operations are allowed),
    /// resources (what can be accessed), and optional conditions for fine-grained
    /// control. Cedar provides a formal policy language designed for authorization
    /// with deterministic evaluation, making policies testable, reviewable, and
    /// auditable. All Cedar policies follow a default-deny model where actions are
    /// denied unless explicitly permitted, and forbid policies always override
    /// permit policies.
    cedar: ?CedarPolicy,

    pub const json_field_names = .{
        .cedar = "cedar",
    };
};
