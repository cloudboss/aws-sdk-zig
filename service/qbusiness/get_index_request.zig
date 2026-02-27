pub const GetIndexRequest = struct {
    /// The identifier of the Amazon Q Business application connected to the index.
    application_id: []const u8,

    /// The identifier of the Amazon Q Business index you want information on.
    index_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .index_id = "indexId",
    };
};
