/// The data that is input into Wisdom as a result of the assistant association.
pub const AssistantAssociationInputData = union(enum) {
    /// The identifier of the knowledge base. This should not be a QUICK_RESPONSES
    /// type knowledge
    /// base if you're storing Wisdom Content resource to it.
    knowledge_base_id: ?[]const u8,

    pub const json_field_names = .{
        .knowledge_base_id = "knowledgeBaseId",
    };
};
