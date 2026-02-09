const BatchStatementError = @import("batch_statement_error.zig").BatchStatementError;

/// A PartiQL batch statement response..
pub const BatchStatementResponse = struct {
    /// The error associated with a failed PartiQL batch statement.
    @"error": ?BatchStatementError,

    /// A DynamoDB item associated with a BatchStatementResponse
    item: ?[]const u8,

    /// The table name associated with a failed PartiQL batch statement.
    table_name: ?[]const u8,
};
