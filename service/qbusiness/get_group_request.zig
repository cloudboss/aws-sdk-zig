pub const GetGroupRequest = struct {
    /// The identifier of the application id the group is attached to.
    application_id: []const u8,

    /// The identifier of the data source the group is attached to.
    data_source_id: ?[]const u8 = null,

    /// The name of the group.
    group_name: []const u8,

    /// The identifier of the index the group is attached to.
    index_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .data_source_id = "dataSourceId",
        .group_name = "groupName",
        .index_id = "indexId",
    };
};
