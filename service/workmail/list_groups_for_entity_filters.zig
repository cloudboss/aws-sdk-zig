/// Filtering options for *ListGroupsForEntity* operation. This is only used as
/// input to Operation.
pub const ListGroupsForEntityFilters = struct {
    /// Filters only group names that start with the provided name prefix.
    group_name_prefix: ?[]const u8,

    pub const json_field_names = .{
        .group_name_prefix = "GroupNamePrefix",
    };
};
