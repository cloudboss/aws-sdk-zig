const WebAppEndpointType = @import("web_app_endpoint_type.zig").WebAppEndpointType;

/// a structure that contains details for the web app.
pub const ListedWebApp = struct {
    /// The `AccessEndpoint` is the URL that you provide to your users for them to
    /// interact with the Transfer Family web app. You can specify a custom URL or
    /// use the default value.
    access_endpoint: ?[]const u8,

    /// The Amazon Resource Name (ARN) for the web app.
    arn: []const u8,

    /// The type of endpoint hosting the web app. Valid values are `PUBLIC` for
    /// publicly accessible endpoints and `VPC` for VPC-hosted endpoints.
    endpoint_type: ?WebAppEndpointType,

    /// The `WebAppEndpoint` is the unique URL for your Transfer Family web app.
    /// This is the value that you use when you configure **Origins** on CloudFront.
    web_app_endpoint: ?[]const u8,

    /// The unique identifier for the web app.
    web_app_id: []const u8,

    pub const json_field_names = .{
        .access_endpoint = "AccessEndpoint",
        .arn = "Arn",
        .endpoint_type = "EndpointType",
        .web_app_endpoint = "WebAppEndpoint",
        .web_app_id = "WebAppId",
    };
};
