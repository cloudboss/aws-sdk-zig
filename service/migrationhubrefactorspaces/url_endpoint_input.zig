/// The configuration for the URL endpoint type.
pub const UrlEndpointInput = struct {
    /// The health check URL of the URL endpoint type. If the URL is a public
    /// endpoint, the
    /// `HealthUrl` must also be a public endpoint. If the URL is a private endpoint
    /// inside a virtual private cloud (VPC), the health URL must also be a private
    /// endpoint, and the
    /// host must be the same as the URL.
    health_url: ?[]const u8 = null,

    /// The URL to route traffic to. The URL must be an [rfc3986-formatted
    /// URL](https://datatracker.ietf.org/doc/html/rfc3986). If the
    /// host is a domain name, the name must be resolvable over the public internet.
    /// If the scheme is
    /// `https`, the top level domain of the host must be listed in the [IANA root
    /// zone database](https://www.iana.org/domains/root/db).
    url: []const u8,

    pub const json_field_names = .{
        .health_url = "HealthUrl",
        .url = "Url",
    };
};
