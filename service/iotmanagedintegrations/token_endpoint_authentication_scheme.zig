pub const TokenEndpointAuthenticationScheme = enum {
    http_basic,
    request_body_credentials,

    pub const json_field_names = .{
        .http_basic = "HTTP_BASIC",
        .request_body_credentials = "REQUEST_BODY_CREDENTIALS",
    };
};
