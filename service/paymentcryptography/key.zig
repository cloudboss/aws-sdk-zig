const aws = @import("aws");

const DeriveKeyUsage = @import("derive_key_usage.zig").DeriveKeyUsage;
const KeyAttributes = @import("key_attributes.zig").KeyAttributes;
const KeyCheckValueAlgorithm = @import("key_check_value_algorithm.zig").KeyCheckValueAlgorithm;
const KeyOrigin = @import("key_origin.zig").KeyOrigin;
const KeyState = @import("key_state.zig").KeyState;
const MultiRegionKeyType = @import("multi_region_key_type.zig").MultiRegionKeyType;
const ReplicationStatusType = @import("replication_status_type.zig").ReplicationStatusType;

/// Metadata about an Amazon Web Services Payment Cryptography key.
pub const Key = struct {
    /// The date and time when the key was created.
    create_timestamp: i64,

    /// The date and time after which Amazon Web Services Payment Cryptography will
    /// delete the key. This value is present only when `KeyState` is
    /// `DELETE_PENDING` and the key is scheduled for deletion.
    delete_pending_timestamp: ?i64,

    /// The date and time after which Amazon Web Services Payment Cryptography will
    /// delete the key. This value is present only when when the `KeyState` is
    /// `DELETE_COMPLETE` and the Amazon Web Services Payment Cryptography key is
    /// deleted.
    delete_timestamp: ?i64,

    /// The cryptographic usage of an ECDH derived key as deﬁned in section A.5.2 of
    /// the TR-31 spec.
    derive_key_usage: ?DeriveKeyUsage,

    /// Specifies whether the key is enabled.
    enabled: bool,

    /// Specifies whether the key is exportable. This data is immutable after the
    /// key is created.
    exportable: bool,

    /// The Amazon Resource Name (ARN) of the key.
    key_arn: []const u8,

    /// The role of the key, the algorithm it supports, and the cryptographic
    /// operations allowed with the key. This data is immutable after the key is
    /// created.
    key_attributes: KeyAttributes,

    /// The key check value (KCV) is used to check if all parties holding a given
    /// key have the same key or to detect that a key has changed.
    key_check_value: []const u8,

    /// The algorithm that Amazon Web Services Payment Cryptography uses to
    /// calculate the key check value (KCV). It is used to validate the key
    /// integrity.
    ///
    /// For TDES keys, the KCV is computed by encrypting 8 bytes, each with value of
    /// zero, with the key to be checked and retaining the 3 highest order bytes of
    /// the encrypted result. For AES keys, the KCV is computed using a CMAC
    /// algorithm where the input data is 16 bytes of zero and retaining the 3
    /// highest order bytes of the encrypted result.
    key_check_value_algorithm: KeyCheckValueAlgorithm,

    /// The source of the key material. For keys created within Amazon Web Services
    /// Payment Cryptography, the value is `AWS_PAYMENT_CRYPTOGRAPHY`. For keys
    /// imported into Amazon Web Services Payment Cryptography, the value is
    /// `EXTERNAL`.
    key_origin: KeyOrigin,

    /// The state of key that is being created or deleted.
    key_state: KeyState,

    /// Indicates whether this key is a Multi-Region key and its role in the
    /// Multi-Region key hierarchy.
    ///
    /// Multi-Region replication keys allow the same key material to be used across
    /// multiple Amazon Web Services Regions. This field specifies whether the key
    /// is a Primary Region key (PRK) (which can be replicated to other Amazon Web
    /// Services Regions) or a Replica Region key (RRK) (which is a copy of a PRK in
    /// another Region). For more information, see [Multi-Region key
    /// replication](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-multi-region-replication.html).
    multi_region_key_type: ?MultiRegionKeyType,

    primary_region: ?[]const u8,

    /// Information about the replication status of the key across different Amazon
    /// Web Services Regions.
    ///
    /// This field provides details about the current state of key replication,
    /// including any status messages or operational information. It helps track the
    /// progress and health of key replication operations.
    replication_status: ?[]const aws.map.MapEntry(ReplicationStatusType),

    /// The date and time after which Amazon Web Services Payment Cryptography will
    /// start using the key material for cryptographic operations.
    usage_start_timestamp: ?i64,

    /// The date and time after which Amazon Web Services Payment Cryptography will
    /// stop using the key material for cryptographic operations.
    usage_stop_timestamp: ?i64,

    /// Indicates whether this key is using the account's default replication
    /// regions configuration for [Multi-Region key
    /// replication](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-multi-region-replication.html).
    ///
    /// When set to `true`, the key automatically replicates to the regions
    /// specified in the account's default replication settings. When set to
    /// `false`, the key has a custom replication configuration that overrides the
    /// account defaults.
    using_default_replication_regions: ?bool,

    pub const json_field_names = .{
        .create_timestamp = "CreateTimestamp",
        .delete_pending_timestamp = "DeletePendingTimestamp",
        .delete_timestamp = "DeleteTimestamp",
        .derive_key_usage = "DeriveKeyUsage",
        .enabled = "Enabled",
        .exportable = "Exportable",
        .key_arn = "KeyArn",
        .key_attributes = "KeyAttributes",
        .key_check_value = "KeyCheckValue",
        .key_check_value_algorithm = "KeyCheckValueAlgorithm",
        .key_origin = "KeyOrigin",
        .key_state = "KeyState",
        .multi_region_key_type = "MultiRegionKeyType",
        .primary_region = "PrimaryRegion",
        .replication_status = "ReplicationStatus",
        .usage_start_timestamp = "UsageStartTimestamp",
        .usage_stop_timestamp = "UsageStopTimestamp",
        .using_default_replication_regions = "UsingDefaultReplicationRegions",
    };
};
