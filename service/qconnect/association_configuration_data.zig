const KnowledgeBaseAssociationConfigurationData = @import("knowledge_base_association_configuration_data.zig").KnowledgeBaseAssociationConfigurationData;

/// A typed union of the data of the configuration for an Amazon Q in Connect
/// Assistant Association.
pub const AssociationConfigurationData = union(enum) {
    /// The data of the configuration for a `KNOWLEDGE_BASE` type Amazon Q in
    /// Connect Assistant Association.
    knowledge_base_association_configuration_data: ?KnowledgeBaseAssociationConfigurationData,

    pub const json_field_names = .{
        .knowledge_base_association_configuration_data = "knowledgeBaseAssociationConfigurationData",
    };
};
