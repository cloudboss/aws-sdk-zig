const HttpRequest = @import("http_request.zig").HttpRequest;

/// Configuration parameters for customizing HTTP requests sent to the ad
/// decision server (ADS). This allows you to specify the HTTP method, headers,
/// request body, and compression settings for ADS requests.
pub const AdDecisionServerConfiguration = struct {
    /// The HTTP request configuration parameters for the ad decision server.
    http_request: ?HttpRequest = null,

    pub const json_field_names = .{
        .http_request = "HttpRequest",
    };
};
