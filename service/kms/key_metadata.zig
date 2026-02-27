const CustomerMasterKeySpec = @import("customer_master_key_spec.zig").CustomerMasterKeySpec;
const EncryptionAlgorithmSpec = @import("encryption_algorithm_spec.zig").EncryptionAlgorithmSpec;
const ExpirationModelType = @import("expiration_model_type.zig").ExpirationModelType;
const KeyAgreementAlgorithmSpec = @import("key_agreement_algorithm_spec.zig").KeyAgreementAlgorithmSpec;
const KeyManagerType = @import("key_manager_type.zig").KeyManagerType;
const KeySpec = @import("key_spec.zig").KeySpec;
const KeyState = @import("key_state.zig").KeyState;
const KeyUsageType = @import("key_usage_type.zig").KeyUsageType;
const MacAlgorithmSpec = @import("mac_algorithm_spec.zig").MacAlgorithmSpec;
const MultiRegionConfiguration = @import("multi_region_configuration.zig").MultiRegionConfiguration;
const OriginType = @import("origin_type.zig").OriginType;
const SigningAlgorithmSpec = @import("signing_algorithm_spec.zig").SigningAlgorithmSpec;
const XksKeyConfigurationType = @import("xks_key_configuration_type.zig").XksKeyConfigurationType;

/// Contains metadata about a KMS key.
///
/// This data type is used as a response element for the CreateKey, DescribeKey,
/// and ReplicateKey operations.
pub const KeyMetadata = struct {
    /// The Amazon Resource Name (ARN) of the KMS key. For examples, see [Key
    /// Management Service
    /// (KMS)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-kms) in the Example ARNs section of the *Amazon Web Services General
    /// Reference*.
    arn: ?[]const u8,

    /// The twelve-digit account ID of the Amazon Web Services account that owns the
    /// KMS key.
    aws_account_id: ?[]const u8,

    /// The cluster ID of the CloudHSM cluster that contains the key material for
    /// the KMS key. When
    /// you create a KMS key in an CloudHSM [custom key
    /// store](https://docs.aws.amazon.com/kms/latest/developerguide/key-store-overview.html), KMS creates the key material for the KMS
    /// key in the associated CloudHSM cluster. This field is present only when the
    /// KMS key is created in
    /// an CloudHSM key store.
    cloud_hsm_cluster_id: ?[]const u8,

    /// The date and time when the KMS key was created.
    creation_date: ?i64,

    /// Identifies the current key material. This value is present for symmetric
    /// encryption keys
    /// with `AWS_KMS` or `EXTERNAL` origin. These KMS keys support automatic
    /// or on-demand key rotation and can have multiple key materials associated
    /// with them. KMS uses
    /// the current key material for both encryption and decryption, and the
    /// non-current key material
    /// for decryption operations only.
    current_key_material_id: ?[]const u8,

    /// Instead, use the `KeySpec` field.
    ///
    /// The `KeySpec` and `CustomerMasterKeySpec` fields have the same
    /// value. We recommend that you use the `KeySpec` field in your code. However,
    /// to
    /// avoid breaking changes, KMS supports both fields.
    customer_master_key_spec: ?CustomerMasterKeySpec,

    /// A unique identifier for the [custom key
    /// store](https://docs.aws.amazon.com/kms/latest/developerguide/key-store-overview.html) that contains the KMS key. This field is
    /// present only when the KMS key is created in a custom key store.
    custom_key_store_id: ?[]const u8,

    /// The date and time after which KMS deletes this KMS key. This value is
    /// present only when
    /// the KMS key is scheduled for deletion, that is, when its `KeyState` is
    /// `PendingDeletion`.
    ///
    /// When the primary key in a multi-Region key is scheduled for deletion but
    /// still has replica
    /// keys, its key state is `PendingReplicaDeletion` and the length of its
    /// waiting
    /// period is displayed in the `PendingDeletionWindowInDays` field.
    deletion_date: ?i64,

    /// The description of the KMS key.
    description: ?[]const u8,

    /// Specifies whether the KMS key is enabled. When `KeyState` is
    /// `Enabled` this value is true, otherwise it is false.
    enabled: bool = false,

    /// The encryption algorithms that the KMS key supports. You cannot use the KMS
    /// key with other
    /// encryption algorithms within KMS.
    ///
    /// This value is present only when the `KeyUsage` of the KMS key is
    /// `ENCRYPT_DECRYPT`.
    encryption_algorithms: ?[]const EncryptionAlgorithmSpec,

    /// Specifies whether the KMS key's key material expires. This value is present
    /// only when
    /// `Origin` is `EXTERNAL`, otherwise this value is omitted.
    expiration_model: ?ExpirationModelType,

    /// The key agreement algorithm used to derive a shared secret.
    key_agreement_algorithms: ?[]const KeyAgreementAlgorithmSpec,

    /// The globally unique identifier for the KMS key.
    key_id: []const u8,

    /// The manager of the KMS key. KMS keys in your Amazon Web Services account are
    /// either customer managed or
    /// Amazon Web Services managed. For more information about the difference, see
    /// [KMS
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#kms_keys) in the *Key Management Service Developer Guide*.
    key_manager: ?KeyManagerType,

    /// Describes the type of key material in the KMS key.
    key_spec: ?KeySpec,

    /// The current status of the KMS key.
    ///
    /// For more information about how key state affects the use of a KMS key, see
    /// [Key states of KMS
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html)
    /// in
    /// the *Key Management Service Developer Guide*.
    key_state: ?KeyState,

    /// The [cryptographic
    /// operations](https://docs.aws.amazon.com/kms/latest/developerguide/kms-cryptography.html#cryptographic-operations) for which you can use the KMS key.
    key_usage: ?KeyUsageType,

    /// The message authentication code (MAC) algorithm that the HMAC KMS key
    /// supports.
    ///
    /// This value is present only when the `KeyUsage` of the KMS key is
    /// `GENERATE_VERIFY_MAC`.
    mac_algorithms: ?[]const MacAlgorithmSpec,

    /// Indicates whether the KMS key is a multi-Region (`True`) or regional
    /// (`False`) key. This value is `True` for multi-Region primary and
    /// replica keys and `False` for regional KMS keys.
    ///
    /// For more information about multi-Region keys, see [Multi-Region keys in
    /// KMS](https://docs.aws.amazon.com/kms/latest/developerguide/multi-region-keys-overview.html) in the *Key Management Service Developer Guide*.
    multi_region: ?bool,

    /// Lists the primary and replica keys in same multi-Region key. This field is
    /// present only
    /// when the value of the `MultiRegion` field is `True`.
    ///
    /// For more information about any listed KMS key, use the DescribeKey
    /// operation.
    ///
    /// * `MultiRegionKeyType` indicates whether the KMS key is a
    /// `PRIMARY` or `REPLICA` key.
    ///
    /// * `PrimaryKey` displays the key ARN and Region of the primary key. This
    ///   field
    /// displays the current KMS key if it is the primary key.
    ///
    /// * `ReplicaKeys` displays the key ARNs and Regions of all replica keys. This
    /// field includes the current KMS key if it is a replica key.
    multi_region_configuration: ?MultiRegionConfiguration,

    /// The source of the key material for the KMS key. When this value is
    /// `AWS_KMS`,
    /// KMS created the key material. When this value is `EXTERNAL`, the key
    /// material was
    /// imported or the KMS key doesn't have any key material. When this value is
    /// `AWS_CLOUDHSM`, the key material was created in the CloudHSM cluster
    /// associated with
    /// a custom key store.
    origin: ?OriginType,

    /// The waiting period before the primary key in a multi-Region key is deleted.
    /// This waiting
    /// period begins when the last of its replica keys is deleted. This value is
    /// present only when
    /// the `KeyState` of the KMS key is `PendingReplicaDeletion`. That
    /// indicates that the KMS key is the primary key in a multi-Region key, it is
    /// scheduled for
    /// deletion, and it still has existing replica keys.
    ///
    /// When a single-Region KMS key or a multi-Region replica key is scheduled for
    /// deletion, its
    /// deletion date is displayed in the `DeletionDate` field. However, when the
    /// primary
    /// key in a multi-Region key is scheduled for deletion, its waiting period
    /// doesn't begin until
    /// all of its replica keys are deleted. This value displays that waiting
    /// period. When the last
    /// replica key in the multi-Region key is deleted, the `KeyState` of the
    /// scheduled
    /// primary key changes from `PendingReplicaDeletion` to `PendingDeletion`
    /// and the deletion date appears in the `DeletionDate` field.
    pending_deletion_window_in_days: ?i32,

    /// The signing algorithms that the KMS key supports. You cannot use the KMS key
    /// with other
    /// signing algorithms within KMS.
    ///
    /// This field appears only when the `KeyUsage` of the KMS key is
    /// `SIGN_VERIFY`.
    signing_algorithms: ?[]const SigningAlgorithmSpec,

    /// The earliest time at which any imported key material permanently associated
    /// with this KMS
    /// key expires. When a key material expires, KMS deletes the key material and
    /// the KMS key
    /// becomes unusable. This value is present only for KMS keys whose `Origin` is
    /// `EXTERNAL` and the `ExpirationModel` is
    /// `KEY_MATERIAL_EXPIRES`, otherwise this value is omitted.
    valid_to: ?i64,

    /// Information about the external key that is associated with a KMS key in an
    /// external key
    /// store.
    ///
    /// For more information, see [External
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/keystore-external.html#concept-external-key) in the
    /// *Key Management Service Developer Guide*.
    xks_key_configuration: ?XksKeyConfigurationType,

    pub const json_field_names = .{
        .arn = "Arn",
        .aws_account_id = "AWSAccountId",
        .cloud_hsm_cluster_id = "CloudHsmClusterId",
        .creation_date = "CreationDate",
        .current_key_material_id = "CurrentKeyMaterialId",
        .customer_master_key_spec = "CustomerMasterKeySpec",
        .custom_key_store_id = "CustomKeyStoreId",
        .deletion_date = "DeletionDate",
        .description = "Description",
        .enabled = "Enabled",
        .encryption_algorithms = "EncryptionAlgorithms",
        .expiration_model = "ExpirationModel",
        .key_agreement_algorithms = "KeyAgreementAlgorithms",
        .key_id = "KeyId",
        .key_manager = "KeyManager",
        .key_spec = "KeySpec",
        .key_state = "KeyState",
        .key_usage = "KeyUsage",
        .mac_algorithms = "MacAlgorithms",
        .multi_region = "MultiRegion",
        .multi_region_configuration = "MultiRegionConfiguration",
        .origin = "Origin",
        .pending_deletion_window_in_days = "PendingDeletionWindowInDays",
        .signing_algorithms = "SigningAlgorithms",
        .valid_to = "ValidTo",
        .xks_key_configuration = "XksKeyConfiguration",
    };
};
