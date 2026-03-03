const aws = @import("aws");

const LineageType = @import("lineage_type.zig").LineageType;

/// A set of filters to narrow the set of lineage entities connected to the
/// `StartArn`(s) returned by the `QueryLineage` API action.
pub const QueryFilters = struct {
    /// Filter the lineage entities connected to the `StartArn`(s) after the create
    /// date.
    created_after: ?i64 = null,

    /// Filter the lineage entities connected to the `StartArn`(s) by created date.
    created_before: ?i64 = null,

    /// Filter the lineage entities connected to the `StartArn`(s) by the type of
    /// the lineage entity.
    lineage_types: ?[]const LineageType = null,

    /// Filter the lineage entities connected to the `StartArn`(s) after the last
    /// modified date.
    modified_after: ?i64 = null,

    /// Filter the lineage entities connected to the `StartArn`(s) before the last
    /// modified date.
    modified_before: ?i64 = null,

    /// Filter the lineage entities connected to the `StartArn`(s) by a set if
    /// property key value pairs. If multiple pairs are provided, an entity is
    /// included in the results if it matches any of the provided pairs.
    properties: ?[]const aws.map.StringMapEntry = null,

    /// Filter the lineage entities connected to the `StartArn` by type. For
    /// example: `DataSet`, `Model`, `Endpoint`, or `ModelDeployment`.
    types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
        .lineage_types = "LineageTypes",
        .modified_after = "ModifiedAfter",
        .modified_before = "ModifiedBefore",
        .properties = "Properties",
        .types = "Types",
    };
};
