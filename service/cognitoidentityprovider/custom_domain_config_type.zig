const SecurityPolicyType = @import("security_policy_type.zig").SecurityPolicyType;

/// The configuration for a custom domain, including the SSL certificate and TLS
/// security
/// policy.
pub const CustomDomainConfigType = struct {
    /// The Amazon Resource Name (ARN) of an Certificate Manager SSL certificate.
    /// You use
    /// this certificate for the subdomain of your custom domain.
    certificate_arn: []const u8,

    /// The security policy for the custom domain. Defines the minimum TLS version
    /// and cipher
    /// suites that Amazon CloudFront supports when communicating with clients. For
    /// specific guidance,
    /// see [Supported protocols and ciphers between viewers and
    /// CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html). Valid values are
    /// as follows:
    ///
    /// * `TLS_V1_3_2025` (strictest): A post-quantum-ready policy requiring TLS
    ///   1.3.
    /// It provides the strongest security posture and is ideal for
    /// workloads where all clients and browsers are updated to the latest
    /// versions. [Supported protocols and ciphers for
    /// TLSv1.3_2025](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html).
    ///
    /// * `TLS_V1_2_2021` (recommended): A post-quantum-ready policy which prefers
    ///   TLS 1.3 but allows
    /// fallback to TLS 1.2 to accommodate older clients. It
    /// is the recommended minimum for typical commercial-grade consumer
    /// applications. [Supported protocols and ciphers for
    /// TLSv1.2_2021](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html).
    ///
    /// * `TLS_V1` (strongly discouraged): Permits fallback to TLS 1.0. It offers
    ///   the broadest
    /// compatibility, including support for legacy clients that are more than a
    /// decade old. This compatibility comes at the expense of allowing TLS versions
    /// and cryptographic algorithms that are no longer considered safe for
    /// commercial use. [Supported protocols and ciphers for
    /// TLSv1](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html).
    security_policy: ?SecurityPolicyType = null,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .security_policy = "SecurityPolicy",
    };
};
