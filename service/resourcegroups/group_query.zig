const ResourceQuery = @import("resource_query.zig").ResourceQuery;

/// A mapping of a query attached to a resource group that determines the Amazon
/// Web Services resources
/// that are members of the group.
pub const GroupQuery = struct {
    /// The name of the resource group that is associated with the specified
    /// resource
    /// query.
    group_name: []const u8,

    /// The resource query that determines which Amazon Web Services resources are
    /// members of the associated
    /// resource group.
    resource_query: ResourceQuery,

    pub const json_field_names = .{
        .group_name = "GroupName",
        .resource_query = "ResourceQuery",
    };
};
