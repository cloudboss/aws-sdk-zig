const Record = @import("record.zig").Record;
const ResultSetMetadata = @import("result_set_metadata.zig").ResultSetMetadata;

/// The result set returned by a SQL statement.
///
/// This data structure is only used with the deprecated `ExecuteSql` operation.
/// Use the `BatchExecuteStatement` or `ExecuteStatement` operation instead.
pub const ResultFrame = struct {
    /// The records in the result set.
    records: ?[]const Record = null,

    /// The result-set metadata in the result set.
    result_set_metadata: ?ResultSetMetadata = null,

    pub const json_field_names = .{
        .records = "records",
        .result_set_metadata = "resultSetMetadata",
    };
};
