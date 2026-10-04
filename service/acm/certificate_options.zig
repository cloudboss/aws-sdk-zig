const CertificateTransparencyLoggingPreference = @import("certificate_transparency_logging_preference.zig").CertificateTransparencyLoggingPreference;
const CertificateExport = @import("certificate_export.zig").CertificateExport;
const ValidationMethod = @import("validation_method.zig").ValidationMethod;

/// Structure that contains options for your certificate. You can use this
/// structure to change the domain validation method or specify whether to
/// export your certificate.
///
/// All public certificates are recorded in a certificate transparency log. For
/// general information, see [Certificate Transparency
/// Logging](https://docs.aws.amazon.com/acm/latest/userguide/acm-concepts.html#concept-transparency).
///
/// You can export public ACM certificates to use with Amazon Web Services
/// services as well as outside Amazon Web Services Cloud. For more information,
/// see [Certificate Manager exportable public
/// certificate](https://docs.aws.amazon.com/acm/latest/userguide/acm-exportable-certificates.html).
pub const CertificateOptions = struct {
    /// This parameter has been deprecated. Certificate transparency logging opt-out
    /// is no longer available. All public certificates are recorded in a
    /// certificate transparency log.
    certificate_transparency_logging_preference: ?CertificateTransparencyLoggingPreference = null,

    /// You can opt in to allow the export of your certificates by specifying
    /// `ENABLED`. You cannot update the value of `Export` after the the certificate
    /// is created.
    @"export": ?CertificateExport = null,

    /// The domain validation method for the certificate. To migrate from email to
    /// DNS validation, specify `DNS`.
    validation_method: ?ValidationMethod = null,

    pub const json_field_names = .{
        .certificate_transparency_logging_preference = "CertificateTransparencyLoggingPreference",
        .@"export" = "Export",
        .validation_method = "ValidationMethod",
    };
};
