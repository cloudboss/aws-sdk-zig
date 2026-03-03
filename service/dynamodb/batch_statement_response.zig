const aws = @import("aws");

const BatchStatementError = @import("batch_statement_error.zig").BatchStatementError;
const AttributeValue = @import("attribute_value.zig").AttributeValue;

/// A PartiQL batch statement response..
pub const BatchStatementResponse = struct {
    /// The error associated with a failed PartiQL batch statement.
    @"error": ?BatchStatementError = null,

    /// A DynamoDB item associated with a BatchStatementResponse
    item: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// The table name associated with a failed PartiQL batch statement.
    table_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .@"error" = "Error",
        .item = "Item",
        .table_name = "TableName",
    };
};
