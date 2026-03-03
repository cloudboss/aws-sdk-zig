const KnowledgeBaseStatus = @import("knowledge_base_status.zig").KnowledgeBaseStatus;

/// Contains details about a knowledge base.
pub const KnowledgeBaseSummary = struct {
    /// The description of the knowledge base.
    description: ?[]const u8 = null,

    /// The unique identifier of the knowledge base.
    knowledge_base_id: []const u8,

    /// The name of the knowledge base.
    name: []const u8,

    /// The status of the knowledge base.
    status: KnowledgeBaseStatus,

    /// The time the knowledge base was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .description = "description",
        .knowledge_base_id = "knowledgeBaseId",
        .name = "name",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
