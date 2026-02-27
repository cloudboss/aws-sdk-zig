const JoinColumn = @import("join_column.zig").JoinColumn;
const JoinType = @import("join_type.zig").JoinType;

/// Specifies a transform that joins two datasets into one dataset using a
/// comparison phrase on the specified data property keys. You can use inner,
/// outer, left, right, left semi, and left anti joins.
pub const Join = struct {
    /// A list of the two columns to be joined.
    columns: []const JoinColumn,

    /// The data inputs identified by their node names.
    inputs: []const []const u8,

    /// Specifies the type of join to be performed on the datasets.
    join_type: JoinType,

    /// The name of the transform node.
    name: []const u8,

    pub const json_field_names = .{
        .columns = "Columns",
        .inputs = "Inputs",
        .join_type = "JoinType",
        .name = "Name",
    };
};
