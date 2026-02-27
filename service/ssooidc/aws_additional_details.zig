/// This structure contains Amazon Web Services-specific parameter extensions
/// and the [identity
/// context](https://docs.aws.amazon.com/singlesignon/latest/userguide/trustedidentitypropagation-overview.html).
pub const AwsAdditionalDetails = struct {
    /// The trusted context assertion is signed and encrypted by STS. It provides
    /// access to
    /// `sts:identity_context` claim in the `idToken` without JWT
    /// parsing
    ///
    /// Identity context comprises information that Amazon Web Services services use
    /// to make authorization
    /// decisions when they receive requests.
    identity_context: ?[]const u8,

    pub const json_field_names = .{
        .identity_context = "identityContext",
    };
};
