const aws = @import("aws");

const AssistantIntegrationConfiguration = @import("assistant_integration_configuration.zig").AssistantIntegrationConfiguration;
const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;
const AssistantStatus = @import("assistant_status.zig").AssistantStatus;
const AssistantType = @import("assistant_type.zig").AssistantType;

/// The assistant data.
pub const AssistantData = struct {
    /// The Amazon Resource Name (ARN) of the Wisdom assistant.
    assistant_arn: []const u8,

    /// The identifier of the Wisdom assistant.
    assistant_id: []const u8,

    /// The description.
    description: ?[]const u8,

    /// The configuration information for the Wisdom assistant integration.
    integration_configuration: ?AssistantIntegrationConfiguration,

    /// The name.
    name: []const u8,

    /// The configuration information for the customer managed key used for
    /// encryption.
    ///
    /// This KMS key must have a policy that allows `kms:CreateGrant`,
    /// `kms:DescribeKey`, and `kms:Decrypt/kms:GenerateDataKey` permissions to the
    /// IAM identity using the key
    /// to invoke Wisdom. To use Wisdom with chat, the key policy must also allow
    /// `kms:Decrypt`, `kms:GenerateDataKey*`, and `kms:DescribeKey`
    /// permissions to the `connect.amazonaws.com` service
    /// principal.
    ///
    /// For more information about setting up a customer managed key for Wisdom, see
    /// [Enable Amazon Connect Wisdom
    /// for your
    /// instance](https://docs.aws.amazon.com/connect/latest/adminguide/enable-wisdom.html).
    server_side_encryption_configuration: ?ServerSideEncryptionConfiguration,

    /// The status of the assistant.
    status: AssistantStatus,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry,

    /// The type of assistant.
    type: AssistantType,

    pub const json_field_names = .{
        .assistant_arn = "assistantArn",
        .assistant_id = "assistantId",
        .description = "description",
        .integration_configuration = "integrationConfiguration",
        .name = "name",
        .server_side_encryption_configuration = "serverSideEncryptionConfiguration",
        .status = "status",
        .tags = "tags",
        .type = "type",
    };
};
