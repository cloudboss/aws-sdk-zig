/// The configuration for the URL endpoint type.
pub const UrlEndpointConfig = struct {
    /// The health check URL of the URL endpoint type.
    health_url: ?[]const u8,

    /// The HTTP URL endpoint.
    url: ?[]const u8,

    pub const json_field_names = .{
        .health_url = "HealthUrl",
        .url = "Url",
    };
};
