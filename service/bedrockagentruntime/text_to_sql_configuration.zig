const TextToSqlKnowledgeBaseConfiguration = @import("text_to_sql_knowledge_base_configuration.zig").TextToSqlKnowledgeBaseConfiguration;
const TextToSqlConfigurationType = @import("text_to_sql_configuration_type.zig").TextToSqlConfigurationType;

/// Contains configurations for transforming text to SQL.
pub const TextToSqlConfiguration = struct {
    /// Specifies configurations for a knowledge base to use in transformation.
    knowledge_base_configuration: ?TextToSqlKnowledgeBaseConfiguration,

    /// The type of resource to use in transformation.
    @"type": TextToSqlConfigurationType,

    pub const json_field_names = .{
        .knowledge_base_configuration = "knowledgeBaseConfiguration",
        .@"type" = "type",
    };
};
