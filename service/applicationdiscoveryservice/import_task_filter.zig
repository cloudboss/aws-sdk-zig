const ImportTaskFilterName = @import("import_task_filter_name.zig").ImportTaskFilterName;

/// A name-values pair of elements you can use to filter the results when
/// querying your import
/// tasks. Currently, wildcards are not supported for filters.
///
/// When filtering by import status, all other filter values are ignored.
pub const ImportTaskFilter = struct {
    /// The name, status, or import task ID for a specific import task.
    name: ?ImportTaskFilterName,

    /// An array of strings that you can provide to match against a specific name,
    /// status, or
    /// import task ID to filter the results for your import task queries.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
