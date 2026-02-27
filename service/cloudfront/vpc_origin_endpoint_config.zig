const OriginProtocolPolicy = @import("origin_protocol_policy.zig").OriginProtocolPolicy;
const OriginSslProtocols = @import("origin_ssl_protocols.zig").OriginSslProtocols;

/// An Amazon CloudFront VPC origin endpoint configuration.
pub const VpcOriginEndpointConfig = struct {
    /// The ARN of the CloudFront VPC origin endpoint configuration.
    arn: []const u8,

    /// The HTTP port for the CloudFront VPC origin endpoint configuration. The
    /// default value is `80`.
    http_port: i32,

    /// The HTTPS port of the CloudFront VPC origin endpoint configuration. The
    /// default value is `443`.
    https_port: i32,

    /// The name of the CloudFront VPC origin endpoint configuration.
    name: []const u8,

    /// The origin protocol policy for the CloudFront VPC origin endpoint
    /// configuration.
    origin_protocol_policy: OriginProtocolPolicy,

    origin_ssl_protocols: ?OriginSslProtocols,
};
