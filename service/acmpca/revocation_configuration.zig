const CrlConfiguration = @import("crl_configuration.zig").CrlConfiguration;
const OcspConfiguration = @import("ocsp_configuration.zig").OcspConfiguration;

/// Certificate revocation information used by the
/// [CreateCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CreateCertificateAuthority.html) and [UpdateCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_UpdateCertificateAuthority.html) actions. Your private certificate authority (CA) can configure Online Certificate Status Protocol (OCSP) support and/or maintain a certificate revocation list (CRL). OCSP returns validation information about certificates as requested by clients, and a CRL contains an updated list of certificates revoked by your CA. For more information, see [RevokeCertificate](https://docs.aws.amazon.com/privateca/latest/APIReference/API_RevokeCertificate.html) and [Setting up a certificate revocation method](https://docs.aws.amazon.com/privateca/latest/userguide/revocation-setup.html) in the *Amazon Web Services Private Certificate Authority User Guide*.
pub const RevocationConfiguration = struct {
    /// Configuration of the certificate revocation list (CRL), if any, maintained
    /// by your private CA. A CRL is typically updated approximately 30 minutes
    /// after a certificate is revoked. If for any reason a CRL update fails, Amazon
    /// Web Services Private CA makes further attempts every 15 minutes.
    crl_configuration: ?CrlConfiguration,

    /// Configuration of Online Certificate Status Protocol (OCSP) support, if any,
    /// maintained by your private CA. When you revoke a certificate, OCSP responses
    /// may take up to 60 minutes to reflect the new status.
    ocsp_configuration: ?OcspConfiguration,

    pub const json_field_names = .{
        .crl_configuration = "CrlConfiguration",
        .ocsp_configuration = "OcspConfiguration",
    };
};
