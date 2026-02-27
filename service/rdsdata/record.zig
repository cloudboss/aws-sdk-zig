const Value = @import("value.zig").Value;

/// A record returned by a call.
///
/// This data structure is only used with the deprecated `ExecuteSql` operation.
/// Use the `BatchExecuteStatement` or `ExecuteStatement` operation instead.
pub const Record = struct {
    /// The values returned in the record.
    values: ?[]const Value,

    pub const json_field_names = .{
        .values = "values",
    };
};
