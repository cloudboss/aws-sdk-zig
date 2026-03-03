const aws = @import("aws");

/// Information about a cell.
pub const CellOutput = struct {
    /// The Amazon Resource Name (ARN) for the cell.
    cell_arn: []const u8,

    /// The name of the cell.
    cell_name: []const u8,

    /// A list of cell ARNs.
    cells: []const []const u8,

    /// The readiness scope for the cell, which can be a cell Amazon Resource Name
    /// (ARN) or a recovery group ARN. This is a list but currently can have only
    /// one element.
    parent_readiness_scopes: []const []const u8,

    /// Tags on the resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .cell_arn = "CellArn",
        .cell_name = "CellName",
        .cells = "Cells",
        .parent_readiness_scopes = "ParentReadinessScopes",
        .tags = "Tags",
    };
};
