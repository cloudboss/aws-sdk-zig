/// Verified Access provides server side encryption by default to data at rest
/// using Amazon Web Services-owned KMS keys. You also have the option of using
/// customer managed KMS keys, which can be specified using the options below.
pub const VerifiedAccessSseSpecificationRequest = struct {
    /// Enable or disable the use of customer managed KMS keys for server side
    /// encryption.
    ///
    /// Valid values: `True` | `False`
    customer_managed_key_enabled: ?bool,

    /// The ARN of the KMS key.
    kms_key_arn: ?[]const u8,
};
