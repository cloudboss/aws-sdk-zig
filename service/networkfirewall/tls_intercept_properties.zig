const TlsInterceptMode = @import("tls_intercept_mode.zig").TlsInterceptMode;

/// TLS decryption on traffic to filter on attributes in the HTTP header.
pub const TlsInterceptProperties = struct {
    /// Private Certificate Authority (PCA) used to issue private TLS certificates
    /// so that the proxy can present PCA-signed certificates which applications
    /// trust through the same root, establishing a secure and consistent trust
    /// model for encrypted communication.
    pca_arn: ?[]const u8,

    /// Specifies whether to enable or disable TLS Intercept Mode.
    tls_intercept_mode: ?TlsInterceptMode,

    pub const json_field_names = .{
        .pca_arn = "PcaArn",
        .tls_intercept_mode = "TlsInterceptMode",
    };
};
