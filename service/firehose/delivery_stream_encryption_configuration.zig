const FailureDescription = @import("failure_description.zig").FailureDescription;
const KeyType = @import("key_type.zig").KeyType;
const DeliveryStreamEncryptionStatus = @import("delivery_stream_encryption_status.zig").DeliveryStreamEncryptionStatus;

/// Contains information about the server-side encryption (SSE) status for the
/// delivery
/// stream, the type customer master key (CMK) in use, if any, and the ARN of
/// the CMK. You can
/// get `DeliveryStreamEncryptionConfiguration` by invoking the
/// DescribeDeliveryStream operation.
pub const DeliveryStreamEncryptionConfiguration = struct {
    /// Provides details in case one of the following operations fails due to an
    /// error related
    /// to KMS: CreateDeliveryStream, DeleteDeliveryStream,
    /// StartDeliveryStreamEncryption, StopDeliveryStreamEncryption.
    failure_description: ?FailureDescription = null,

    /// If `KeyType` is `CUSTOMER_MANAGED_CMK`, this field contains the
    /// ARN of the customer managed CMK. If `KeyType` is `Amazon Web
    /// Services_OWNED_CMK`, `DeliveryStreamEncryptionConfiguration` doesn't contain
    /// a value for `KeyARN`.
    key_arn: ?[]const u8 = null,

    /// Indicates the type of customer master key (CMK) that is used for encryption.
    /// The default
    /// setting is `Amazon Web Services_OWNED_CMK`. For more information about CMKs,
    /// see
    /// [Customer Master Keys
    /// (CMKs)](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#master_keys).
    key_type: ?KeyType = null,

    /// This is the server-side encryption (SSE) status for the Firehose stream. For
    /// a full
    /// description of the different values of this status, see
    /// StartDeliveryStreamEncryption and StopDeliveryStreamEncryption. If this
    /// status is `ENABLING_FAILED`
    /// or `DISABLING_FAILED`, it is the status of the most recent attempt to enable
    /// or
    /// disable SSE, respectively.
    status: ?DeliveryStreamEncryptionStatus = null,

    pub const json_field_names = .{
        .failure_description = "FailureDescription",
        .key_arn = "KeyARN",
        .key_type = "KeyType",
        .status = "Status",
    };
};
