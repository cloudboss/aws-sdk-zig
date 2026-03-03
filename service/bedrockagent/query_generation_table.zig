const QueryGenerationColumn = @import("query_generation_column.zig").QueryGenerationColumn;
const IncludeExclude = @import("include_exclude.zig").IncludeExclude;

/// Contains information about a table for the query engine to consider.
pub const QueryGenerationTable = struct {
    /// An array of objects, each of which defines information about a column in the
    /// table.
    columns: ?[]const QueryGenerationColumn = null,

    /// A description of the table that helps the query engine understand the
    /// contents of the table.
    description: ?[]const u8 = null,

    /// Specifies whether to include or exclude the table during query generation.
    /// If you specify `EXCLUDE`, the table will be ignored. If you specify
    /// `INCLUDE`, all other tables will be ignored.
    inclusion: ?IncludeExclude = null,

    /// The name of the table for which the other fields in this object apply.
    name: []const u8,

    pub const json_field_names = .{
        .columns = "columns",
        .description = "description",
        .inclusion = "inclusion",
        .name = "name",
    };
};
