/// The trust store used for mutual TLS authentication. It contains the
/// certificate authority (CA) certificates and optional certificate revocation
/// list (CRL).
pub const TrustStore = struct {
    /// The PEM-encoded certificate authority (CA) certificates bundle for the trust
    /// store.
    ca_content: []const u8,

    /// The PEM-encoded certificate revocation lists (CRLs) for the trust store.
    /// There can be one CRL per certificate authority (CA) in the trust store.
    crl_content: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the trust
    /// store contents.
    kms_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .ca_content = "CAContent",
        .crl_content = "CrlContent",
        .kms_key_arn = "KmsKeyArn",
    };
};
