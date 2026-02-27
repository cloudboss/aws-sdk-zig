const aws = @import("aws");

const KnowledgeBaseType = @import("knowledge_base_type.zig").KnowledgeBaseType;
const RenderingConfiguration = @import("rendering_configuration.zig").RenderingConfiguration;
const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;
const SourceConfiguration = @import("source_configuration.zig").SourceConfiguration;
const KnowledgeBaseStatus = @import("knowledge_base_status.zig").KnowledgeBaseStatus;
const VectorIngestionConfiguration = @import("vector_ingestion_configuration.zig").VectorIngestionConfiguration;

/// Summary information about the knowledge base.
pub const KnowledgeBaseSummary = struct {
    /// The description of the knowledge base.
    description: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: []const u8,

    /// The identifier of the knowledge base.
    knowledge_base_id: []const u8,

    /// The type of knowledge base.
    knowledge_base_type: KnowledgeBaseType,

    /// The name of the knowledge base.
    name: []const u8,

    /// Information about how to render the content.
    rendering_configuration: ?RenderingConfiguration,

    /// The configuration information for the customer managed key used for
    /// encryption.
    ///
    /// This KMS key must have a policy that allows `kms:CreateGrant`,
    /// `kms:DescribeKey`, `kms:Decrypt`, and `kms:GenerateDataKey*` permissions to
    /// the IAM identity using the key to invoke Amazon Q in Connect.
    ///
    /// For more information about setting up a customer managed key for Amazon Q in
    /// Connect, see [Enable Amazon Q in Connect for your
    /// instance](https://docs.aws.amazon.com/connect/latest/adminguide/enable-q.html).
    server_side_encryption_configuration: ?ServerSideEncryptionConfiguration,

    /// Configuration information about the external data source.
    source_configuration: ?SourceConfiguration,

    /// The status of the knowledge base summary.
    status: KnowledgeBaseStatus,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry,

    /// Contains details about how to ingest the documents in a data source.
    vector_ingestion_configuration: ?VectorIngestionConfiguration,

    pub const json_field_names = .{
        .description = "description",
        .knowledge_base_arn = "knowledgeBaseArn",
        .knowledge_base_id = "knowledgeBaseId",
        .knowledge_base_type = "knowledgeBaseType",
        .name = "name",
        .rendering_configuration = "renderingConfiguration",
        .server_side_encryption_configuration = "serverSideEncryptionConfiguration",
        .source_configuration = "sourceConfiguration",
        .status = "status",
        .tags = "tags",
        .vector_ingestion_configuration = "vectorIngestionConfiguration",
    };
};
