const KeyAttributes = @import("key_attributes.zig").KeyAttributes;
const KeyState = @import("key_state.zig").KeyState;
const MultiRegionKeyType = @import("multi_region_key_type.zig").MultiRegionKeyType;

/// Metadata about an Amazon Web Services Payment Cryptography key.
pub const KeySummary = struct {
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

    /// The state of an Amazon Web Services Payment Cryptography that is being
    /// created or deleted.
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
    multi_region_key_type: ?MultiRegionKeyType = null,

    primary_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .exportable = "Exportable",
        .key_arn = "KeyArn",
        .key_attributes = "KeyAttributes",
        .key_check_value = "KeyCheckValue",
        .key_state = "KeyState",
        .multi_region_key_type = "MultiRegionKeyType",
        .primary_region = "PrimaryRegion",
    };
};
