/// Information about an HTTP request.
pub const Http = struct {
    /// The IP address of the requestor.
    client_ip: ?[]const u8,

    /// The request method.
    http_method: ?[]const u8,

    /// The response status.
    http_status: ?i32,

    /// The request URL.
    http_url: ?[]const u8,

    /// The request's user agent string.
    user_agent: ?[]const u8,

    pub const json_field_names = .{
        .client_ip = "ClientIp",
        .http_method = "HttpMethod",
        .http_status = "HttpStatus",
        .http_url = "HttpURL",
        .user_agent = "UserAgent",
    };
};
