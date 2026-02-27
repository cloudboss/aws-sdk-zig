/// The count of resources that are grouped by the group name.
pub const GroupedResourceCount = struct {
    /// The name of the group that can be region, account ID, or resource type. For
    /// example, region1, region2 if the region was chosen as `GroupByKey`.
    group_name: []const u8,

    /// The number of resources in the group.
    resource_count: i64 = 0,

    pub const json_field_names = .{
        .group_name = "GroupName",
        .resource_count = "ResourceCount",
    };
};
