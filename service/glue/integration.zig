const aws = @import("aws");

const IntegrationError = @import("integration_error.zig").IntegrationError;
const IntegrationConfig = @import("integration_config.zig").IntegrationConfig;
const IntegrationStatus = @import("integration_status.zig").IntegrationStatus;
const Tag = @import("tag.zig").Tag;

/// Describes a zero-ETL integration.
pub const Integration = struct {
    /// An optional set of non-secret key–value pairs that contains additional
    /// contextual information for encryption. This can only be provided if
    /// `KMSKeyId` is provided.
    additional_encryption_context: ?[]const aws.map.StringMapEntry,

    /// The time that the integration was created, in UTC.
    create_time: i64,

    /// Selects source tables for the integration using Maxwell filter syntax.
    data_filter: ?[]const u8,

    /// A description for the integration.
    description: ?[]const u8,

    /// A list of errors associated with the integration.
    errors: ?[]const IntegrationError,

    /// The Amazon Resource Name (ARN) for the integration.
    integration_arn: []const u8,

    /// Properties associated with the integration.
    integration_config: ?IntegrationConfig,

    /// A unique name for the integration.
    integration_name: []const u8,

    /// The ARN of a KMS key used for encrypting the channel.
    kms_key_id: ?[]const u8,

    /// The ARN for the source of the integration.
    source_arn: []const u8,

    /// The possible statuses are:
    ///
    /// * CREATING: The integration is being created.
    ///
    /// * ACTIVE: The integration creation succeeds.
    ///
    /// * MODIFYING: The integration is being modified.
    ///
    /// * FAILED: The integration creation fails.
    ///
    /// * DELETING: The integration is deleted.
    ///
    /// * SYNCING: The integration is synchronizing.
    ///
    /// * NEEDS_ATTENTION: The integration needs attention, such as synchronization.
    status: IntegrationStatus,

    /// Metadata assigned to the resource consisting of a list of key-value pairs.
    tags: ?[]const Tag,

    /// The ARN for the target of the integration.
    target_arn: []const u8,

    pub const json_field_names = .{
        .additional_encryption_context = "AdditionalEncryptionContext",
        .create_time = "CreateTime",
        .data_filter = "DataFilter",
        .description = "Description",
        .errors = "Errors",
        .integration_arn = "IntegrationArn",
        .integration_config = "IntegrationConfig",
        .integration_name = "IntegrationName",
        .kms_key_id = "KmsKeyId",
        .source_arn = "SourceArn",
        .status = "Status",
        .tags = "Tags",
        .target_arn = "TargetArn",
    };
};
