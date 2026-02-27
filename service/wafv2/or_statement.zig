const Statement = @import("statement.zig").Statement;

/// A logical rule statement used to combine other rule statements with OR
/// logic. You provide more than one Statement within the `OrStatement`.
pub const OrStatement = struct {
    /// The statements to combine with OR logic. You can use any statements that can
    /// be
    /// nested.
    statements: []const Statement,

    pub const json_field_names = .{
        .statements = "Statements",
    };
};
