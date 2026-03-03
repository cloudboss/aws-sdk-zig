const HttpHeader = @import("http_header.zig").HttpHeader;

/// Contextual user data used for evaluating the risk of an authentication event
/// by user
/// pool threat protection.
pub const ContextDataType = struct {
    /// Encoded device-fingerprint details that your app collected with the Amazon
    /// Cognito
    /// context data collection library. For more information, see [Adding user
    /// device and session data to API
    /// requests](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-settings-adaptive-authentication.html#user-pool-settings-adaptive-authentication-device-fingerprint).
    encoded_data: ?[]const u8 = null,

    /// The HTTP headers from your user's authentication request.
    http_headers: []const HttpHeader,

    /// The source IP address of your user's device.
    ip_address: []const u8,

    /// The name of your application's service endpoint.
    server_name: []const u8,

    /// The path of your application's service endpoint.
    server_path: []const u8,

    pub const json_field_names = .{
        .encoded_data = "EncodedData",
        .http_headers = "HttpHeaders",
        .ip_address = "IpAddress",
        .server_name = "ServerName",
        .server_path = "ServerPath",
    };
};
