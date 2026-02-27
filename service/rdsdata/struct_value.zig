const Value = @import("value.zig").Value;

/// A structure value returned by a call.
///
/// This data structure is only used with the deprecated `ExecuteSql` operation.
/// Use the `BatchExecuteStatement` or `ExecuteStatement` operation instead.
pub const StructValue = struct {
    /// The attributes returned in the record.
    attributes: ?[]const Value,

    pub const json_field_names = .{
        .attributes = "attributes",
    };
};
