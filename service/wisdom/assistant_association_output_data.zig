const KnowledgeBaseAssociationData = @import("knowledge_base_association_data.zig").KnowledgeBaseAssociationData;

/// The data that is output as a result of the assistant association.
pub const AssistantAssociationOutputData = union(enum) {
    /// The knowledge base where output data is sent.
    knowledge_base_association: ?KnowledgeBaseAssociationData,

    pub const json_field_names = .{
        .knowledge_base_association = "knowledgeBaseAssociation",
    };
};
