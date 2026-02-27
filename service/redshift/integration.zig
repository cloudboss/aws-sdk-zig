const aws = @import("aws");

const IntegrationError = @import("integration_error.zig").IntegrationError;
const ZeroETLIntegrationStatus = @import("zero_etl_integration_status.zig").ZeroETLIntegrationStatus;
const Tag = @import("tag.zig").Tag;

pub const Integration = struct {
    /// The encryption context for the integration. For more information,
    /// see [Encryption
    /// context](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context) in the *Amazon Web Services Key Management Service Developer
    /// Guide*.
    additional_encryption_context: ?[]const aws.map.StringMapEntry,

    /// The time (UTC) when the integration was created.
    create_time: ?i64,

    /// The description of the integration.
    description: ?[]const u8,

    /// Any errors associated with the integration.
    errors: ?[]const IntegrationError,

    /// The Amazon Resource Name (ARN) of the integration.
    integration_arn: ?[]const u8,

    /// The name of the integration.
    integration_name: ?[]const u8,

    /// The Key Management Service (KMS) key identifier for the key used to
    /// encrypt the integration.
    kms_key_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the database used as the source for
    /// replication.
    source_arn: ?[]const u8,

    /// The current status of the integration.
    status: ?ZeroETLIntegrationStatus,

    /// The list of tags associated with the integration.
    tags: ?[]const Tag,

    /// The Amazon Resource Name (ARN) of the Amazon Redshift data warehouse to use
    /// as the target for replication.
    target_arn: ?[]const u8,
};
