/// An AgentCore Cedar or Dogwood policy statement, which supports plain Cedar
/// policies, temporal policies, and guardrails definitions.
pub const PolicyStatement = struct {
    /// The body of the AgentCore Cedar or Dogwood policy statement. Contains the
    /// policy logic, which can be a Cedar policy, a temporal policy, or a
    /// guardrails definition.
    statement: []const u8,

    pub const json_field_names = .{
        .statement = "statement",
    };
};
