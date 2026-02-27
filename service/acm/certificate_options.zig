const CertificateTransparencyLoggingPreference = @import("certificate_transparency_logging_preference.zig").CertificateTransparencyLoggingPreference;
const CertificateExport = @import("certificate_export.zig").CertificateExport;

/// Structure that contains options for your certificate. You can use this
/// structure to specify whether to opt in to or out of certificate transparency
/// logging and export your certificate.
///
/// Some browsers require that public certificates issued for your domain be
/// recorded in a log. Certificates that are not logged typically generate a
/// browser error. Transparency makes it possible for you to detect SSL/TLS
/// certificates that have been mistakenly or maliciously issued for your
/// domain. For general information, see [Certificate Transparency
/// Logging](https://docs.aws.amazon.com/acm/latest/userguide/acm-concepts.html#concept-transparency).
///
/// You can export public ACM certificates to use with Amazon Web Services
/// services as well as outside Amazon Web Services Cloud. For more information,
/// see [Certificate Manager exportable public
/// certificate](https://docs.aws.amazon.com/acm/latest/userguide/acm-exportable-certificates.html).
pub const CertificateOptions = struct {
    /// You can opt out of certificate transparency logging by specifying the
    /// `DISABLED` option. Opt in by specifying `ENABLED`.
    certificate_transparency_logging_preference: ?CertificateTransparencyLoggingPreference,

    /// You can opt in to allow the export of your certificates by specifying
    /// `ENABLED`.
    @"export": ?CertificateExport,

    pub const json_field_names = .{
        .certificate_transparency_logging_preference = "CertificateTransparencyLoggingPreference",
        .@"export" = "Export",
    };
};
