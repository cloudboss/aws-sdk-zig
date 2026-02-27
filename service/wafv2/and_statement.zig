const Statement = @import("statement.zig").Statement;

/// A logical rule statement used to combine other rule statements with AND
/// logic. You provide more than one Statement within the `AndStatement`.
pub const AndStatement = struct {
    /// The statements to combine with AND logic. You can use any statements that
    /// can be nested.
    statements: []const Statement,

    pub const json_field_names = .{
        .statements = "Statements",
    };
};
