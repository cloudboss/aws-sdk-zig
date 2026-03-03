const aws = @import("aws");

const IntegrationError = @import("integration_error.zig").IntegrationError;
const IntegrationStatus = @import("integration_status.zig").IntegrationStatus;
const Tag = @import("tag.zig").Tag;

/// A zero-ETL integration with Amazon Redshift.
pub const Integration = struct {
    /// The encryption context for the integration. For more information, see
    /// [Encryption
    /// context](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context) in the *Amazon Web Services Key Management Service Developer Guide*.
    additional_encryption_context: ?[]const aws.map.StringMapEntry = null,

    /// The time when the integration was created, in Universal Coordinated Time
    /// (UTC).
    create_time: ?i64 = null,

    /// Data filters for the integration. These filters determine which tables from
    /// the source database are sent to the target Amazon Redshift data warehouse.
    data_filter: ?[]const u8 = null,

    /// A description of the integration.
    description: ?[]const u8 = null,

    /// Any errors associated with the integration.
    errors: ?[]const IntegrationError = null,

    /// The ARN of the integration.
    integration_arn: ?[]const u8 = null,

    /// The name of the integration.
    integration_name: ?[]const u8 = null,

    /// The Amazon Web Services Key Management System (Amazon Web Services KMS) key
    /// identifier for the key used to to encrypt the integration.
    kms_key_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the database used as the source for
    /// replication.
    source_arn: ?[]const u8 = null,

    /// The current status of the integration.
    status: ?IntegrationStatus = null,

    tags: ?[]const Tag = null,

    /// The ARN of the Redshift data warehouse used as the target for replication.
    target_arn: ?[]const u8 = null,
};
