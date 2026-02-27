const KnowledgeBaseConfiguration = @import("knowledge_base_configuration.zig").KnowledgeBaseConfiguration;
const KnowledgeBaseStatus = @import("knowledge_base_status.zig").KnowledgeBaseStatus;
const StorageConfiguration = @import("storage_configuration.zig").StorageConfiguration;

/// Contains information about a knowledge base.
pub const KnowledgeBase = struct {
    /// The time the knowledge base was created.
    created_at: i64,

    /// The description of the knowledge base.
    description: ?[]const u8,

    /// A list of reasons that the API operation on the knowledge base failed.
    failure_reasons: ?[]const []const u8,

    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: []const u8,

    /// Contains details about the embeddings configuration of the knowledge base.
    knowledge_base_configuration: KnowledgeBaseConfiguration,

    /// The unique identifier of the knowledge base.
    knowledge_base_id: []const u8,

    /// The name of the knowledge base.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role with permissions to invoke
    /// API operations on the knowledge base.
    role_arn: []const u8,

    /// The status of the knowledge base. The following statuses are possible:
    ///
    /// * CREATING – The knowledge base is being created.
    /// * ACTIVE – The knowledge base is ready to be queried.
    /// * DELETING – The knowledge base is being deleted.
    /// * UPDATING – The knowledge base is being updated.
    /// * FAILED – The knowledge base API operation failed.
    status: KnowledgeBaseStatus,

    /// Contains details about the storage configuration of the knowledge base.
    storage_configuration: ?StorageConfiguration,

    /// The time the knowledge base was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .failure_reasons = "failureReasons",
        .knowledge_base_arn = "knowledgeBaseArn",
        .knowledge_base_configuration = "knowledgeBaseConfiguration",
        .knowledge_base_id = "knowledgeBaseId",
        .name = "name",
        .role_arn = "roleArn",
        .status = "status",
        .storage_configuration = "storageConfiguration",
        .updated_at = "updatedAt",
    };
};
