const aws = @import("aws");

const IntegrationError = @import("integration_error.zig").IntegrationError;
const IntegrationStatus = @import("integration_status.zig").IntegrationStatus;
const Tag = @import("tag.zig").Tag;

/// A zero-ETL integration with Amazon Redshift.
pub const Integration = struct {
    /// The encryption context for the integration. For more information, see
    /// [Encryption
    /// context](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context) in the *Amazon Web Services Key Management Service Developer Guide*.
    additional_encryption_context: ?[]const aws.map.StringMapEntry,

    /// The time when the integration was created, in Universal Coordinated Time
    /// (UTC).
    create_time: ?i64,

    /// Data filters for the integration. These filters determine which tables from
    /// the source database are sent to the target Amazon Redshift data warehouse.
    data_filter: ?[]const u8,

    /// A description of the integration.
    description: ?[]const u8,

    /// Any errors associated with the integration.
    errors: ?[]const IntegrationError,

    /// The ARN of the integration.
    integration_arn: ?[]const u8,

    /// The name of the integration.
    integration_name: ?[]const u8,

    /// The Amazon Web Services Key Management System (Amazon Web Services KMS) key
    /// identifier for the key used to to encrypt the integration.
    kms_key_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the database used as the source for
    /// replication.
    source_arn: ?[]const u8,

    /// The current status of the integration.
    status: ?IntegrationStatus,

    tags: ?[]const Tag,

    /// The ARN of the Redshift data warehouse used as the target for replication.
    target_arn: ?[]const u8,
};
