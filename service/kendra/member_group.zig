/// The sub groups that belong to a group.
pub const MemberGroup = struct {
    /// The identifier of the data source for the sub group you want to map to a
    /// group.
    data_source_id: ?[]const u8,

    /// The identifier of the sub group you want to map to a group.
    group_id: []const u8,

    pub const json_field_names = .{
        .data_source_id = "DataSourceId",
        .group_id = "GroupId",
    };
};
