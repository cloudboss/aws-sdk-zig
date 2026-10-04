const AccessControlConfiguration = @import("access_control_configuration.zig").AccessControlConfiguration;
const KnowledgeBaseIngestionSummary = @import("knowledge_base_ingestion_summary.zig").KnowledgeBaseIngestionSummary;
const KnowledgeBaseConfiguration = @import("knowledge_base_configuration.zig").KnowledgeBaseConfiguration;
const MediaExtractionConfiguration = @import("media_extraction_configuration.zig").MediaExtractionConfiguration;
const DataSetStatus = @import("data_set_status.zig").DataSetStatus;

/// A knowledge base resource that provides data from connected sources for
/// AI-powered experiences in Amazon QuickSight.
pub const KnowledgeBase = struct {
    /// The access control configuration for the knowledge base.
    access_control_configuration: ?AccessControlConfiguration = null,

    /// The date and time that the knowledge base was created.
    created_at: ?i64 = null,

    /// The ARN of the data source associated with the knowledge base.
    data_source_arn: []const u8,

    /// The description of the knowledge base.
    description: ?[]const u8 = null,

    /// The number of documents in the knowledge base.
    document_count: ?i64 = null,

    /// A summary of the first completed ingestion for the knowledge base.
    first_completed_ingestion_summary: ?KnowledgeBaseIngestionSummary = null,

    /// A summary of the first incomplete ingestion for the knowledge base.
    first_incomplete_ingestion_summary: ?KnowledgeBaseIngestionSummary = null,

    /// Specifies whether email notifications are enabled for ingestion failures.
    is_email_notification_opted_for_ingestion_failures: ?bool = null,

    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: []const u8,

    /// The configuration settings for the knowledge base.
    knowledge_base_configuration: KnowledgeBaseConfiguration,

    /// The unique identifier for the knowledge base.
    knowledge_base_id: []const u8,

    /// The size of the knowledge base in bytes.
    knowledge_base_size_bytes: ?i64 = null,

    /// A summary of the most recent ingestion for the knowledge base.
    latest_ingestion_summary: ?KnowledgeBaseIngestionSummary = null,

    /// The media extraction configuration for the knowledge base.
    media_extraction_configuration: ?MediaExtractionConfiguration = null,

    /// The name of the knowledge base.
    name: []const u8,

    /// The ARN of the primary owner of the knowledge base.
    primary_owner_arn: ?[]const u8 = null,

    /// The username of the primary owner of the knowledge base.
    primary_owner_username: ?[]const u8 = null,

    /// The status of the knowledge base.
    status: DataSetStatus,

    /// The type of the knowledge base.
    @"type": ?[]const u8 = null,

    /// The date and time that the knowledge base was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .access_control_configuration = "AccessControlConfiguration",
        .created_at = "CreatedAt",
        .data_source_arn = "DataSourceArn",
        .description = "Description",
        .document_count = "DocumentCount",
        .first_completed_ingestion_summary = "FirstCompletedIngestionSummary",
        .first_incomplete_ingestion_summary = "FirstIncompleteIngestionSummary",
        .is_email_notification_opted_for_ingestion_failures = "IsEmailNotificationOptedForIngestionFailures",
        .knowledge_base_arn = "KnowledgeBaseArn",
        .knowledge_base_configuration = "KnowledgeBaseConfiguration",
        .knowledge_base_id = "KnowledgeBaseId",
        .knowledge_base_size_bytes = "KnowledgeBaseSizeBytes",
        .latest_ingestion_summary = "LatestIngestionSummary",
        .media_extraction_configuration = "MediaExtractionConfiguration",
        .name = "Name",
        .primary_owner_arn = "PrimaryOwnerArn",
        .primary_owner_username = "PrimaryOwnerUsername",
        .status = "Status",
        .@"type" = "Type",
        .updated_at = "UpdatedAt",
    };
};
