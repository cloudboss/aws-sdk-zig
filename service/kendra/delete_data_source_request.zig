pub const DeleteDataSourceRequest = struct {
    /// The identifier of the data source connector you want to delete.
    id: []const u8,

    /// The identifier of the index used with the data source connector.
    index_id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
        .index_id = "IndexId",
    };
};
