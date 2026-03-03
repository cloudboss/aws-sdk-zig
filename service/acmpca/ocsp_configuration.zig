/// Contains information to enable and configure Online Certificate Status
/// Protocol (OCSP) for validating certificate revocation status.
///
/// When you revoke a certificate, OCSP responses may take up to 60 minutes to
/// reflect the new status.
pub const OcspConfiguration = struct {
    /// Flag enabling use of the Online Certificate Status Protocol (OCSP) for
    /// validating certificate revocation status.
    enabled: bool,

    /// By default, Amazon Web Services Private CA injects an Amazon Web Services
    /// domain into certificates being validated by the Online Certificate Status
    /// Protocol (OCSP). A customer can alternatively use this object to define a
    /// CNAME specifying a customized OCSP domain.
    ///
    /// The content of a Canonical Name (CNAME) record must conform to
    /// [RFC2396](https://www.ietf.org/rfc/rfc2396.txt) restrictions on the use of
    /// special characters in URIs. Additionally, the value of the CNAME must not
    /// include a protocol prefix such as "http://" or "https://".
    ///
    /// For more information, see [Customizing Online Certificate Status Protocol
    /// (OCSP)
    /// ](https://docs.aws.amazon.com/privateca/latest/userguide/ocsp-customize.html) in the *Amazon Web Services Private Certificate Authority User Guide*.
    ocsp_custom_cname: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .ocsp_custom_cname = "OcspCustomCname",
    };
};
