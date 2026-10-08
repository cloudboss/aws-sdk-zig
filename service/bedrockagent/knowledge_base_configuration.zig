const KendraKnowledgeBaseConfiguration = @import("kendra_knowledge_base_configuration.zig").KendraKnowledgeBaseConfiguration;
const ManagedKnowledgeBaseConfiguration = @import("managed_knowledge_base_configuration.zig").ManagedKnowledgeBaseConfiguration;
const SqlKnowledgeBaseConfiguration = @import("sql_knowledge_base_configuration.zig").SqlKnowledgeBaseConfiguration;
const KnowledgeBaseType = @import("knowledge_base_type.zig").KnowledgeBaseType;
const VectorKnowledgeBaseConfiguration = @import("vector_knowledge_base_configuration.zig").VectorKnowledgeBaseConfiguration;

/// Contains details about the vector embeddings configuration of the knowledge
/// base.
pub const KnowledgeBaseConfiguration = struct {
    /// Settings for an Amazon Kendra knowledge base.
    kendra_knowledge_base_configuration: ?KendraKnowledgeBaseConfiguration = null,

    /// Contains configuration details for a knowledge base that uses a vector store
    /// fully managed by Amazon Bedrock. Specify this object when the knowledge base
    /// type is MANAGED.
    managed_knowledge_base_configuration: ?ManagedKnowledgeBaseConfiguration = null,

    /// Specifies configurations for a knowledge base connected to an SQL database.
    sql_knowledge_base_configuration: ?SqlKnowledgeBaseConfiguration = null,

    /// The type of data that the data source is converted into for the knowledge
    /// base. Choose `MANAGED` to create a managed knowledge base.
    type: KnowledgeBaseType,

    /// Contains details about the model that's used to convert the data source into
    /// vector embeddings.
    vector_knowledge_base_configuration: ?VectorKnowledgeBaseConfiguration = null,

    pub const json_field_names = .{
        .kendra_knowledge_base_configuration = "kendraKnowledgeBaseConfiguration",
        .managed_knowledge_base_configuration = "managedKnowledgeBaseConfiguration",
        .sql_knowledge_base_configuration = "sqlKnowledgeBaseConfiguration",
        .type = "type",
        .vector_knowledge_base_configuration = "vectorKnowledgeBaseConfiguration",
    };
};
