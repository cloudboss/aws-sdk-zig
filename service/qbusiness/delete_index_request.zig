pub const DeleteIndexRequest = struct {
    /// The identifier of the Amazon Q Business application the Amazon Q Business
    /// index is linked to.
    application_id: []const u8,

    /// The identifier of the Amazon Q Business index.
    index_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .index_id = "indexId",
    };
};
