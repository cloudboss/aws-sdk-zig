/// KMS uses the authentication credential to sign requests that it sends to the
/// external
/// key store proxy (XKS proxy) on your behalf. You establish these credentials
/// on your external
/// key store proxy and report them to KMS.
///
/// The `XksProxyAuthenticationCredential` includes two required elements.
pub const XksProxyAuthenticationCredentialType = struct {
    /// A unique identifier for the raw secret access key.
    access_key_id: []const u8,

    /// A secret string of 43-64 characters. Valid characters are a-z, A-Z, 0-9, /,
    /// +, and
    /// =.
    raw_secret_access_key: []const u8,

    pub const json_field_names = .{
        .access_key_id = "AccessKeyId",
        .raw_secret_access_key = "RawSecretAccessKey",
    };
};
