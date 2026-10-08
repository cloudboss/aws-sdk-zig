const MatchedStatement = @import("matched_statement.zig").MatchedStatement;

/// A policy that matched during evaluation, referenced by URI. The URI
/// corresponds to a policy in the top-level policies list.
pub const MatchedPolicy = struct {
    /// The statements within the policy that matched during the evaluation.
    matched_statements: ?[]const MatchedStatement = null,

    /// The URI of the policy. This cross-references an entry in the top-level
    /// policies list. The value depends on the policy type:
    ///
    /// * For managed policies, this is the policy ARN.
    /// * For inline policies, this is an opaque identifier.
    uri: []const u8,

    pub const json_field_names = .{
        .matched_statements = "matchedStatements",
        .uri = "uri",
    };
};
