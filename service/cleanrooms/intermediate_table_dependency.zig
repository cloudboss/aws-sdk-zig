const BaseTableParentType = @import("base_table_parent_type.zig").BaseTableParentType;
const BaseTableDependencyType = @import("base_table_dependency_type.zig").BaseTableDependencyType;

/// Contains information about a base table that an intermediate table depends
/// on.
pub const IntermediateTableDependency = struct {
    /// The Amazon Web Services account ID of the member who owns the dependency
    /// table.
    creator_account_id: []const u8,

    /// The unique identifier of the dependency table.
    id: []const u8,

    /// The name of the dependency table.
    name: []const u8,

    /// The type of dependency, either direct or indirect. A direct dependency is a
    /// table explicitly referenced in the stored query. An indirect dependency is a
    /// table referenced through another intermediate table.
    parent_type: BaseTableParentType,

    /// The type of the dependency table.
    @"type": BaseTableDependencyType,

    pub const json_field_names = .{
        .creator_account_id = "creatorAccountId",
        .id = "id",
        .name = "name",
        .parent_type = "parentType",
        .@"type" = "type",
    };
};
