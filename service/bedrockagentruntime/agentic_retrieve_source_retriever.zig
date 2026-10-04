/// A source retriever that produced retrieval results.
pub const AgenticRetrieveSourceRetriever = struct {
    /// The unique identifier of the source retriever.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "identifier",
    };
};
