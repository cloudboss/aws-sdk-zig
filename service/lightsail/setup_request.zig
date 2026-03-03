const CertificateProvider = @import("certificate_provider.zig").CertificateProvider;

/// Returns information that was submitted during the `SetupInstanceHttps`
/// request.
/// Email information is redacted for privacy.
pub const SetupRequest = struct {
    /// The Certificate Authority (CA) that issues the SSL/TLS certificate.
    certificate_provider: ?CertificateProvider = null,

    /// The name of the domain and subdomains that the SSL/TLS certificate secures.
    domain_names: ?[]const []const u8 = null,

    /// The name of the Lightsail instance.
    instance_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_provider = "certificateProvider",
        .domain_names = "domainNames",
        .instance_name = "instanceName",
    };
};
