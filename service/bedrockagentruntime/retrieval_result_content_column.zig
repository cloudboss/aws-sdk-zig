const RetrievalResultContentColumnType = @import("retrieval_result_content_column_type.zig").RetrievalResultContentColumnType;

/// Contains information about a column with a cell to return in retrieval.
pub const RetrievalResultContentColumn = struct {
    /// The name of the column.
    column_name: ?[]const u8,

    /// The value in the column.
    column_value: ?[]const u8,

    /// The data type of the value.
    @"type": ?RetrievalResultContentColumnType,

    pub const json_field_names = .{
        .column_name = "columnName",
        .column_value = "columnValue",
        .@"type" = "type",
    };
};
