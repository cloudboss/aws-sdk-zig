/// Represents a Cedar policy statement within the AgentCore Policy system.
/// Cedar is a policy language designed for authorization that provides
/// human-readable, analyzable, and high-performance policy evaluation for
/// controlling agent behavior and access decisions.
pub const CedarPolicy = struct {
    /// The Cedar policy statement that defines the authorization logic. This
    /// statement follows Cedar syntax and specifies principals, actions, resources,
    /// and conditions that determine when access should be allowed or denied.
    statement: []const u8,

    pub const json_field_names = .{
        .statement = "statement",
    };
};
