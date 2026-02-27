const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const OriginMtlsConfig = @import("origin_mtls_config.zig").OriginMtlsConfig;
const OriginProtocolPolicy = @import("origin_protocol_policy.zig").OriginProtocolPolicy;
const OriginSslProtocols = @import("origin_ssl_protocols.zig").OriginSslProtocols;

/// A custom origin. A custom origin is any origin that is *not* an Amazon S3
/// bucket, with one exception. An Amazon S3 bucket that is [configured with
/// static website
/// hosting](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html) *is* a custom origin.
pub const CustomOriginConfig = struct {
    /// The HTTP port that CloudFront uses to connect to the origin. Specify the
    /// HTTP port that the origin listens on.
    http_port: i32,

    /// The HTTPS port that CloudFront uses to connect to the origin. Specify the
    /// HTTPS port that the origin listens on.
    https_port: i32,

    /// Specifies which IP protocol CloudFront uses when connecting to your origin.
    /// If your origin uses both IPv4 and IPv6 protocols, you can choose `dualstack`
    /// to help optimize reliability.
    ip_address_type: ?IpAddressType,

    /// Specifies how long, in seconds, CloudFront persists its connection to the
    /// origin. The minimum timeout is 1 second, the maximum is 120 seconds, and the
    /// default (if you don't specify otherwise) is 5 seconds.
    ///
    /// For more information, see [Keep-alive timeout (custom origins
    /// only)](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/DownloadDistValuesOrigin.html#DownloadDistValuesOriginKeepaliveTimeout) in the *Amazon CloudFront Developer Guide*.
    origin_keepalive_timeout: ?i32,

    /// Configures mutual TLS authentication between CloudFront and your origin
    /// server.
    origin_mtls_config: ?OriginMtlsConfig,

    /// Specifies the protocol (HTTP or HTTPS) that CloudFront uses to connect to
    /// the origin. Valid values are:
    ///
    /// * `http-only` – CloudFront always uses HTTP to connect to the origin.
    /// * `match-viewer` – CloudFront connects to the origin using the same protocol
    ///   that the viewer used to connect to CloudFront.
    /// * `https-only` – CloudFront always uses HTTPS to connect to the origin.
    origin_protocol_policy: OriginProtocolPolicy,

    /// Specifies how long, in seconds, CloudFront waits for a response from the
    /// origin. This is also known as the *origin response timeout*. The minimum
    /// timeout is 1 second, the maximum is 120 seconds, and the default (if you
    /// don't specify otherwise) is 30 seconds.
    ///
    /// For more information, see [Response
    /// timeout](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/DownloadDistValuesOrigin.html#DownloadDistValuesOriginResponseTimeout) in the *Amazon CloudFront Developer Guide*.
    origin_read_timeout: ?i32,

    /// Specifies the minimum SSL/TLS protocol that CloudFront uses when connecting
    /// to your origin over HTTPS. Valid values include `SSLv3`, `TLSv1`, `TLSv1.1`,
    /// and `TLSv1.2`.
    ///
    /// For more information, see [Minimum Origin SSL
    /// Protocol](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/DownloadDistValuesOrigin.html#DownloadDistValuesOriginSSLProtocols) in the *Amazon CloudFront Developer Guide*.
    origin_ssl_protocols: ?OriginSslProtocols,
};
