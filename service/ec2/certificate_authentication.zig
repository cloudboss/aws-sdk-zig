/// Information about the client certificate used for authentication.
pub const CertificateAuthentication = struct {
    /// The ARN of the client certificate.
    client_root_certificate_chain: ?[]const u8,
};
