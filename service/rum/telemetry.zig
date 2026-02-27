pub const Telemetry = enum {
    /// Includes JS error event plugin
    errors,
    /// Includes navigation, paint, resource and web vital event plugins
    performance,
    /// Includes X-Ray Xhr and X-Ray Fetch plugin
    http,

    pub const json_field_names = .{
        .errors = "ERRORS",
        .performance = "PERFORMANCE",
        .http = "HTTP",
    };
};
