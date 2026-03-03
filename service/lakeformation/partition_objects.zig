const TableObject = @import("table_object.zig").TableObject;

/// A structure containing a list of partition values and table objects.
pub const PartitionObjects = struct {
    /// A list of table objects
    objects: ?[]const TableObject = null,

    /// A list of partition values.
    partition_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .objects = "Objects",
        .partition_values = "PartitionValues",
    };
};
