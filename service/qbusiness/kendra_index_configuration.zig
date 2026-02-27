/// Stores an Amazon Kendra index as a retriever.
pub const KendraIndexConfiguration = struct {
    /// The identifier of the Amazon Kendra index.
    index_id: []const u8,

    pub const json_field_names = .{
        .index_id = "indexId",
    };
};
