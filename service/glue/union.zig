const UnionType = @import("union_type.zig").UnionType;

/// Specifies a transform that combines the rows from two or more datasets into
/// a single result.
pub const Union = struct {
    /// The node ID inputs to the transform.
    inputs: []const []const u8,

    /// The name of the transform node.
    name: []const u8,

    /// Indicates the type of Union transform.
    ///
    /// Specify `ALL` to join all rows from data sources to the resulting
    /// DynamicFrame. The resulting union does not remove duplicate rows.
    ///
    /// Specify `DISTINCT` to remove duplicate rows in the resulting DynamicFrame.
    union_type: UnionType,

    pub const json_field_names = .{
        .inputs = "Inputs",
        .name = "Name",
        .union_type = "UnionType",
    };
};
