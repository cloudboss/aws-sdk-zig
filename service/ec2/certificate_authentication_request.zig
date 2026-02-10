/// Information about the client certificate to be used for authentication.
pub const CertificateAuthenticationRequest = struct {
    /// The ARN of the client certificate. The certificate must be signed by a
    /// certificate
    /// authority (CA) and it must be provisioned in Certificate Manager (ACM).
    client_root_certificate_chain_arn: ?[]const u8,
};
