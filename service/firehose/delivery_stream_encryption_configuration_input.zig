const KeyType = @import("key_type.zig").KeyType;

/// Specifies the type and Amazon Resource Name (ARN) of the CMK to use for
/// Server-Side
/// Encryption (SSE).
pub const DeliveryStreamEncryptionConfigurationInput = struct {
    /// If you set `KeyType` to `CUSTOMER_MANAGED_CMK`, you must specify
    /// the Amazon Resource Name (ARN) of the CMK. If you set `KeyType` to `Amazon
    /// Web Services_OWNED_CMK`, Firehose uses a service-account CMK.
    key_arn: ?[]const u8,

    /// Indicates the type of customer master key (CMK) to use for encryption. The
    /// default
    /// setting is `Amazon Web Services_OWNED_CMK`. For more information about CMKs,
    /// see
    /// [Customer Master Keys
    /// (CMKs)](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#master_keys). When you invoke CreateDeliveryStream or StartDeliveryStreamEncryption with
    /// `KeyType` set to CUSTOMER_MANAGED_CMK, Firehose invokes the
    /// Amazon KMS operation
    /// [CreateGrant](https://docs.aws.amazon.com/kms/latest/APIReference/API_CreateGrant.html) to create a grant
    /// that allows the Firehose service to use the customer managed CMK to perform
    /// encryption and decryption. Firehose manages that grant.
    ///
    /// When you invoke StartDeliveryStreamEncryption to change the CMK for a
    /// Firehose stream that is encrypted with a customer managed CMK, Firehose
    /// schedules the grant it had on the old CMK for retirement.
    ///
    /// You can use a CMK of type CUSTOMER_MANAGED_CMK to encrypt up to 500 Firehose
    /// streams. If
    /// a CreateDeliveryStream or StartDeliveryStreamEncryption
    /// operation exceeds this limit, Firehose throws a
    /// `LimitExceededException`.
    ///
    /// To encrypt your Firehose stream, use symmetric CMKs. Firehose doesn't
    /// support asymmetric CMKs. For information about symmetric and asymmetric
    /// CMKs, see [About
    /// Symmetric and Asymmetric
    /// CMKs](https://docs.aws.amazon.com/kms/latest/developerguide/symm-asymm-concepts.html) in the Amazon Web Services Key Management
    /// Service developer guide.
    key_type: KeyType,

    pub const json_field_names = .{
        .key_arn = "KeyARN",
        .key_type = "KeyType",
    };
};
