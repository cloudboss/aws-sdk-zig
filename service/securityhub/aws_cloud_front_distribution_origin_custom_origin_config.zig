const AwsCloudFrontDistributionOriginSslProtocols = @import("aws_cloud_front_distribution_origin_ssl_protocols.zig").AwsCloudFrontDistributionOriginSslProtocols;

/// A custom origin. A custom origin is any origin that is not an Amazon S3
/// bucket, with one exception. An Amazon S3 bucket that is [configured with
/// static website
/// hosting](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html) is a custom origin.
pub const AwsCloudFrontDistributionOriginCustomOriginConfig = struct {
    /// The HTTP port that CloudFront uses to connect to the origin.
    http_port: ?i32,

    /// The HTTPS port that CloudFront uses to connect to the origin.
    https_port: ?i32,

    /// Specifies how long, in seconds, CloudFront persists its connection to the
    /// origin.
    origin_keepalive_timeout: ?i32,

    /// Specifies the protocol (HTTP or HTTPS) that CloudFront uses to connect to
    /// the origin.
    origin_protocol_policy: ?[]const u8,

    /// Specifies how long, in seconds, CloudFront waits for a response from the
    /// origin.
    origin_read_timeout: ?i32,

    /// Specifies the minimum SSL/TLS protocol that CloudFront uses when connecting
    /// to your origin over HTTPS.
    origin_ssl_protocols: ?AwsCloudFrontDistributionOriginSslProtocols,

    pub const json_field_names = .{
        .http_port = "HttpPort",
        .https_port = "HttpsPort",
        .origin_keepalive_timeout = "OriginKeepaliveTimeout",
        .origin_protocol_policy = "OriginProtocolPolicy",
        .origin_read_timeout = "OriginReadTimeout",
        .origin_ssl_protocols = "OriginSslProtocols",
    };
};
