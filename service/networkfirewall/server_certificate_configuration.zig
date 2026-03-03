const CheckCertificateRevocationStatusActions = @import("check_certificate_revocation_status_actions.zig").CheckCertificateRevocationStatusActions;
const ServerCertificateScope = @import("server_certificate_scope.zig").ServerCertificateScope;
const ServerCertificate = @import("server_certificate.zig").ServerCertificate;

/// Configures the Certificate Manager certificates and scope that Network
/// Firewall uses to decrypt and re-encrypt traffic using a
/// TLSInspectionConfiguration. You can configure `ServerCertificates` for
/// inbound SSL/TLS inspection, a `CertificateAuthorityArn` for outbound SSL/TLS
/// inspection, or both. For information about working with certificates for TLS
/// inspection, see [ Using SSL/TLS server certficiates with TLS inspection
/// configurations](https://docs.aws.amazon.com/network-firewall/latest/developerguide/tls-inspection-certificate-requirements.html) in the *Network Firewall Developer Guide*.
///
/// If a server certificate that's associated with your
/// TLSInspectionConfiguration is revoked, deleted, or expired it can result in
/// client-side TLS errors.
pub const ServerCertificateConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the imported certificate authority (CA)
    /// certificate within Certificate Manager (ACM) to use for outbound SSL/TLS
    /// inspection.
    ///
    /// The following limitations apply:
    ///
    /// * You can use CA certificates that you imported into ACM, but you can't
    ///   generate CA certificates with ACM.
    ///
    /// * You can't use certificates issued by Private Certificate Authority.
    ///
    /// For more information about configuring certificates for outbound inspection,
    /// see [Using SSL/TLS certificates with TLS inspection
    /// configurations](https://docs.aws.amazon.com/network-firewall/latest/developerguide/tls-inspection-certificate-requirements.html) in the *Network Firewall Developer Guide*.
    ///
    /// For information about working with certificates in ACM, see [Importing
    /// certificates](https://docs.aws.amazon.com/acm/latest/userguide/import-certificate.html) in the *Certificate Manager User Guide*.
    certificate_authority_arn: ?[]const u8 = null,

    /// When enabled, Network Firewall checks if the server certificate presented by
    /// the server in the SSL/TLS connection has a revoked or unkown status. If the
    /// certificate has an unknown or revoked status, you must specify the actions
    /// that Network Firewall takes on outbound traffic. To check the certificate
    /// revocation status, you must also specify a `CertificateAuthorityArn` in
    /// ServerCertificateConfiguration.
    check_certificate_revocation_status: ?CheckCertificateRevocationStatusActions = null,

    /// A list of scopes.
    scopes: ?[]const ServerCertificateScope = null,

    /// The list of server certificates to use for inbound SSL/TLS inspection.
    server_certificates: ?[]const ServerCertificate = null,

    pub const json_field_names = .{
        .certificate_authority_arn = "CertificateAuthorityArn",
        .check_certificate_revocation_status = "CheckCertificateRevocationStatus",
        .scopes = "Scopes",
        .server_certificates = "ServerCertificates",
    };
};
