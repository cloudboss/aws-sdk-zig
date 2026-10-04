const Column = @import("column.zig").Column;

/// Contains the schema definition of an intermediate table.
pub const IntermediateTableSchema = struct {
    /// The list of columns in the intermediate table schema.
    columns: []const Column,

    pub const json_field_names = .{
        .columns = "columns",
    };
};
