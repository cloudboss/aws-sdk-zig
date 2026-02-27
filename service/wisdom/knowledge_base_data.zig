const aws = @import("aws");

const KnowledgeBaseType = @import("knowledge_base_type.zig").KnowledgeBaseType;
const RenderingConfiguration = @import("rendering_configuration.zig").RenderingConfiguration;
const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;
const SourceConfiguration = @import("source_configuration.zig").SourceConfiguration;
const KnowledgeBaseStatus = @import("knowledge_base_status.zig").KnowledgeBaseStatus;

/// Information about the knowledge base.
pub const KnowledgeBaseData = struct {
    /// The description.
    description: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: []const u8,

    /// The identifier of the knowledge base. This should not be a QUICK_RESPONSES
    /// type knowledge
    /// base if you're storing Wisdom Content resource to it.
    knowledge_base_id: []const u8,

    /// The type of knowledge base.
    knowledge_base_type: KnowledgeBaseType,

    /// An epoch timestamp indicating the most recent content modification inside
    /// the knowledge
    /// base. If no content exists in a knowledge base, this value is unset.
    last_content_modification_time: ?i64,

    /// The name of the knowledge base.
    name: []const u8,

    /// Information about how to render the content.
    rendering_configuration: ?RenderingConfiguration,

    /// The configuration information for the customer managed key used for
    /// encryption.
    ///
    /// This KMS key must have a policy that allows `kms:CreateGrant`,
    /// `kms:DescribeKey`, and `kms:Decrypt/kms:GenerateDataKey` permissions to the
    /// IAM identity using the key
    /// to invoke Wisdom.
    ///
    /// For more information about setting up a customer managed key for Wisdom, see
    /// [Enable Amazon Connect Wisdom
    /// for your
    /// instance](https://docs.aws.amazon.com/connect/latest/adminguide/enable-wisdom.html).
    server_side_encryption_configuration: ?ServerSideEncryptionConfiguration,

    /// Source configuration information about the knowledge base.
    source_configuration: ?SourceConfiguration,

    /// The status of the knowledge base.
    status: KnowledgeBaseStatus,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .description = "description",
        .knowledge_base_arn = "knowledgeBaseArn",
        .knowledge_base_id = "knowledgeBaseId",
        .knowledge_base_type = "knowledgeBaseType",
        .last_content_modification_time = "lastContentModificationTime",
        .name = "name",
        .rendering_configuration = "renderingConfiguration",
        .server_side_encryption_configuration = "serverSideEncryptionConfiguration",
        .source_configuration = "sourceConfiguration",
        .status = "status",
        .tags = "tags",
    };
};
