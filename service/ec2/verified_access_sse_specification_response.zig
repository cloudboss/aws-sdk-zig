/// The options in use for server side encryption.
pub const VerifiedAccessSseSpecificationResponse = struct {
    /// Indicates whether customer managed KMS keys are in use for server side
    /// encryption.
    ///
    /// Valid values: `True` | `False`
    customer_managed_key_enabled: ?bool,

    /// The ARN of the KMS key.
    kms_key_arn: ?[]const u8,
};
