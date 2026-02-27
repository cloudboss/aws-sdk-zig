/// Provides the name of the columns that are required to overlap.
pub const QueryConstraintRequireOverlap = struct {
    /// The columns that are required to overlap.
    columns: ?[]const []const u8,

    pub const json_field_names = .{
        .columns = "columns",
    };
};
