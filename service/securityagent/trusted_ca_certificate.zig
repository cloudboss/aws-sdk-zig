const CaCertificateSource = @import("ca_certificate_source.zig").CaCertificateSource;

/// A trust anchor used when validating a target endpoint's TLS certificate.
pub const TrustedCaCertificate = struct {
    /// The source that Security Agent reads the certificate from.
    source: CaCertificateSource,

    pub const json_field_names = .{
        .source = "source",
    };
};
