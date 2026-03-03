const LineageType = @import("lineage_type.zig").LineageType;

/// A lineage entity connected to the starting entity(ies).
pub const Vertex = struct {
    /// The Amazon Resource Name (ARN) of the lineage entity resource.
    arn: ?[]const u8 = null,

    /// The type of resource of the lineage entity.
    lineage_type: ?LineageType = null,

    /// The type of the lineage entity resource. For example: `DataSet`, `Model`,
    /// `Endpoint`, etc...
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .lineage_type = "LineageType",
        .@"type" = "Type",
    };
};
