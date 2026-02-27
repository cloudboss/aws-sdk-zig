/// Configures mutual TLS authentication between CloudFront and your origin
/// server.
pub const OriginMtlsConfig = struct {
    /// The Amazon Resource Name (ARN) of the client certificate stored in Amazon
    /// Web Services Certificate Manager (ACM) that CloudFront uses to authenticate
    /// with your origin using Mutual TLS.
    client_certificate_arn: []const u8,
};
