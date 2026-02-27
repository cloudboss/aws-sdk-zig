const SslProtocol = @import("ssl_protocol.zig").SslProtocol;

/// A complex type that contains information about the SSL/TLS protocols that
/// CloudFront can use when establishing an HTTPS connection with your origin.
pub const OriginSslProtocols = struct {
    /// A list that contains allowed SSL/TLS protocols for this distribution.
    items: []const SslProtocol,

    /// The number of SSL/TLS protocols that you want to allow CloudFront to use
    /// when establishing an HTTPS connection with this origin.
    quantity: i32,
};
