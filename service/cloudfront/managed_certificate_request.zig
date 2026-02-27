const CertificateTransparencyLoggingPreference = @import("certificate_transparency_logging_preference.zig").CertificateTransparencyLoggingPreference;
const ValidationTokenHost = @import("validation_token_host.zig").ValidationTokenHost;

/// An object that represents the request for the Amazon CloudFront managed ACM
/// certificate.
pub const ManagedCertificateRequest = struct {
    /// You can opt out of certificate transparency logging by specifying the
    /// `disabled` option. Opt in by specifying `enabled`. For more information, see
    /// [Certificate Transparency Logging
    /// ](https://docs.aws.amazon.com/acm/latest/userguide/acm-concepts.html#concept-transparency) in the *Certificate Manager User Guide*.
    certificate_transparency_logging_preference: ?CertificateTransparencyLoggingPreference,

    /// The primary domain name associated with the CloudFront managed ACM
    /// certificate.
    primary_domain_name: ?[]const u8,

    /// Specify how the HTTP validation token will be served when requesting the
    /// CloudFront managed ACM certificate.
    ///
    /// * For `cloudfront`, CloudFront will automatically serve the validation
    ///   token. Choose this mode if you can point the domain's DNS to CloudFront
    ///   immediately.
    /// * For `self-hosted`, you serve the validation token from your existing
    ///   infrastructure. Choose this mode when you need to maintain current traffic
    ///   flow while your certificate is being issued. You can place the validation
    ///   token at the well-known path on your existing web server, wait for ACM to
    ///   validate and issue the certificate, and then update your DNS to point to
    ///   CloudFront.
    validation_token_host: ValidationTokenHost,
};
