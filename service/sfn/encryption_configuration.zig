const EncryptionType = @import("encryption_type.zig").EncryptionType;

/// Settings to configure server-side encryption.
///
/// For additional control over security, you can encrypt your data using a
/// **customer-managed key** for Step Functions state machines and activities.
/// You can configure a symmetric KMS key and data key reuse period when
/// creating or updating a **State Machine**, and when creating an **Activity**.
/// The execution history and state machine definition will be encrypted with
/// the key applied to the State Machine. Activity inputs will be encrypted with
/// the key applied to the Activity.
///
/// Step Functions automatically enables encryption at rest using Amazon Web
/// Services owned keys at no charge. However, KMS charges apply when using a
/// customer managed key. For more information about pricing, see [Key
/// Management Service pricing](https://aws.amazon.com/kms/pricing/).
///
/// For more information on KMS, see [What is Key Management
/// Service?](https://docs.aws.amazon.com/kms/latest/developerguide/overview.html)
pub const EncryptionConfiguration = struct {
    /// Maximum duration that Step Functions will reuse data keys. When the period
    /// expires, Step Functions will call `GenerateDataKey`. Only applies to
    /// customer managed keys.
    kms_data_key_reuse_period_seconds: ?i32 = null,

    /// An alias, alias ARN, key ID, or key ARN of a symmetric encryption KMS key to
    /// encrypt data. To specify a KMS key in a different Amazon Web Services
    /// account, you must use the key ARN or alias ARN.
    kms_key_id: ?[]const u8 = null,

    /// Encryption type
    @"type": EncryptionType,

    pub const json_field_names = .{
        .kms_data_key_reuse_period_seconds = "kmsDataKeyReusePeriodSeconds",
        .kms_key_id = "kmsKeyId",
        .@"type" = "type",
    };
};
