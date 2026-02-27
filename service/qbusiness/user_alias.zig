/// Aliases attached to a user id within an Amazon Q Business application.
pub const UserAlias = struct {
    /// The identifier of the data source that the user aliases are associated with.
    data_source_id: ?[]const u8,

    /// The identifier of the index that the user aliases are associated with.
    index_id: ?[]const u8,

    /// The identifier of the user id associated with the user aliases.
    user_id: []const u8,

    pub const json_field_names = .{
        .data_source_id = "dataSourceId",
        .index_id = "indexId",
        .user_id = "userId",
    };
};
