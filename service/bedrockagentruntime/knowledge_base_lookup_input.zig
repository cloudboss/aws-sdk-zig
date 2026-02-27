/// Contains details about the knowledge base to look up and the query to be
/// made.
pub const KnowledgeBaseLookupInput = struct {
    /// The unique identifier of the knowledge base to look up.
    knowledge_base_id: ?[]const u8,

    /// The query made to the knowledge base.
    text: ?[]const u8,

    pub const json_field_names = .{
        .knowledge_base_id = "knowledgeBaseId",
        .text = "text",
    };
};
