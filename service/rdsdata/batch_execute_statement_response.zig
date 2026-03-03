const UpdateResult = @import("update_result.zig").UpdateResult;

/// The response elements represent the output of a SQL statement over an array
/// of
/// data.
pub const BatchExecuteStatementResponse = struct {
    /// The execution results of each batch entry.
    update_results: ?[]const UpdateResult = null,

    pub const json_field_names = .{
        .update_results = "updateResults",
    };
};
