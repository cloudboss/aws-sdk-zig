const BatchStatementErrorCodeEnum = @import("batch_statement_error_code_enum.zig").BatchStatementErrorCodeEnum;

/// An error associated with a statement in a PartiQL batch that was run.
pub const BatchStatementError = struct {
    /// The error code associated with the failed PartiQL batch statement.
    code: ?BatchStatementErrorCodeEnum,

    /// The item which caused the condition check to fail. This will be set if
    /// ReturnValuesOnConditionCheckFailure is specified as `ALL_OLD`.
    item: ?[]const u8,

    /// The error message associated with the PartiQL batch response.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
        .item = "Item",
        .message = "Message",
    };
};
