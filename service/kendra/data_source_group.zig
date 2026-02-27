/// Data source information for user context filtering.
pub const DataSourceGroup = struct {
    /// The identifier of the data source group you want to add to your list of data
    /// source
    /// groups. This is for filtering search results based on the groups' access to
    /// documents in
    /// that data source.
    data_source_id: []const u8,

    /// The identifier of the group you want to add to your list of groups. This is
    /// for
    /// filtering search results based on the groups' access to documents.
    group_id: []const u8,

    pub const json_field_names = .{
        .data_source_id = "DataSourceId",
        .group_id = "GroupId",
    };
};
