const HttpRequest = @import("http_request.zig").HttpRequest;
const VastResponse = @import("vast_response.zig").VastResponse;

/// Configuration parameters for customizing HTTP requests sent to the ad
/// decision server (ADS). This allows you to specify the HTTP method, headers,
/// request body, and compression settings for ADS requests.
pub const AdDecisionServerConfiguration = struct {
    /// The HTTP request configuration parameters for the ad decision server.
    http_request: ?HttpRequest = null,

    /// The settings that control how MediaTailor processes VAST responses from the
    /// ad decision server.
    vast_response: ?VastResponse = null,

    pub const json_field_names = .{
        .http_request = "HttpRequest",
        .vast_response = "VastResponse",
    };
};
