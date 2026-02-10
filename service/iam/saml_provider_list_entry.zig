/// Contains the list of SAML providers for this account.
pub const SAMLProviderListEntry = struct {
    /// The Amazon Resource Name (ARN) of the SAML provider.
    arn: ?[]const u8,

    /// The date and time when the SAML provider was created.
    create_date: ?i64,

    /// The expiration date and time for the SAML provider.
    valid_until: ?i64,
};
