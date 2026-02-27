const Statement = @import("statement.zig").Statement;

/// A logical rule statement used to negate the results of another rule
/// statement. You provide one Statement within the `NotStatement`.
pub const NotStatement = struct {
    /// The statement to negate. You can use any statement that can be nested.
    statement: ?*Statement = null,

    pub const json_field_names = .{
        .statement = "Statement",
    };
};
