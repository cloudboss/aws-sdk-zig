const IncludeExclude = @import("include_exclude.zig").IncludeExclude;

/// Contains information about a column in the current table for the query
/// engine to consider.
pub const QueryGenerationColumn = struct {
    /// A description of the column that helps the query engine understand the
    /// contents of the column.
    description: ?[]const u8,

    /// Specifies whether to include or exclude the column during query generation.
    /// If you specify `EXCLUDE`, the column will be ignored. If you specify
    /// `INCLUDE`, all other columns in the table will be ignored.
    inclusion: ?IncludeExclude,

    /// The name of the column for which the other fields in this object apply.
    name: ?[]const u8,

    pub const json_field_names = .{
        .description = "description",
        .inclusion = "inclusion",
        .name = "name",
    };
};
