const aws = @import("aws");

const KnowledgeBaseType = @import("knowledge_base_type.zig").KnowledgeBaseType;
const RenderingConfiguration = @import("rendering_configuration.zig").RenderingConfiguration;
const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;
const SourceConfiguration = @import("source_configuration.zig").SourceConfiguration;
const KnowledgeBaseStatus = @import("knowledge_base_status.zig").KnowledgeBaseStatus;

/// Summary information about the knowledge base.
pub const KnowledgeBaseSummary = struct {
    /// The description of the knowledge base.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: []const u8,

    /// The identifier of the knowledge base. This should not be a QUICK_RESPONSES
    /// type knowledge
    /// base if you're storing Wisdom Content resource to it.
    knowledge_base_id: []const u8,

    /// The type of knowledge base.
    knowledge_base_type: KnowledgeBaseType,

    /// The name of the knowledge base.
    name: []const u8,

    /// Information about how to render the content.
    rendering_configuration: ?RenderingConfiguration = null,

    /// The configuration information for the customer managed key used for
    /// encryption.
    ///
    /// This KMS key must have a policy that allows `kms:CreateGrant`,
    /// `kms:DescribeKey`, `kms:Decrypt/kms:GenerateDataKey` permissions to the IAM
    /// identity using the key
    /// to invoke Wisdom.
    ///
    /// For more information about setting up a customer managed key for Wisdom, see
    /// [Enable Amazon Connect Wisdom
    /// for your
    /// instance](https://docs.aws.amazon.com/connect/latest/adminguide/enable-wisdom.html).
    server_side_encryption_configuration: ?ServerSideEncryptionConfiguration = null,

    /// Configuration information about the external data source.
    source_configuration: ?SourceConfiguration = null,

    /// The status of the knowledge base summary.
    status: KnowledgeBaseStatus,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

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
    };
};
