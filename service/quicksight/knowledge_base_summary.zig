const DataSetStatus = @import("data_set_status.zig").DataSetStatus;

/// A summary of a knowledge base, including its identifier, name, status, and
/// metadata.
pub const KnowledgeBaseSummary = struct {
    /// The date and time that the knowledge base was created.
    created_at: ?i64 = null,

    /// The ARN of the data source associated with the knowledge base.
    data_source_arn: []const u8,

    /// The number of documents in the knowledge base.
    document_count: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: []const u8,

    /// The unique identifier for the knowledge base.
    knowledge_base_id: []const u8,

    /// The size of the knowledge base in bytes.
    knowledge_base_size_bytes: ?i64 = null,

    /// The name of the knowledge base.
    name: []const u8,

    /// The ARN of the primary owner of the knowledge base.
    primary_owner_arn: ?[]const u8 = null,

    /// The username of the primary owner of the knowledge base.
    primary_owner_username: ?[]const u8 = null,

    /// The status of the knowledge base.
    status: DataSetStatus,

    /// The type of the knowledge base.
    type: ?[]const u8 = null,

    /// The date and time that the knowledge base was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .data_source_arn = "DataSourceArn",
        .document_count = "DocumentCount",
        .knowledge_base_arn = "KnowledgeBaseArn",
        .knowledge_base_id = "KnowledgeBaseId",
        .knowledge_base_size_bytes = "KnowledgeBaseSizeBytes",
        .name = "Name",
        .primary_owner_arn = "PrimaryOwnerArn",
        .primary_owner_username = "PrimaryOwnerUsername",
        .status = "Status",
        .type = "Type",
        .updated_at = "UpdatedAt",
    };
};
