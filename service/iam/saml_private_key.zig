/// Contains the private keys for the SAML provider.
///
/// This data type is used as a response element in the
/// [GetSAMLProvider](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetSAMLProvider.html)
/// operation.
pub const SAMLPrivateKey = struct {
    /// The unique identifier for the SAML private key.
    key_id: ?[]const u8 = null,

    /// The date and time, in [ISO 8601 date-time
    /// ](http://www.iso.org/iso/iso8601) format, when the private key was uploaded.
    timestamp: ?i64 = null,
};
