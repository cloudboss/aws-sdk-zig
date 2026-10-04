const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Authorization = @import("authorization.zig").Authorization;
const EndpointConfigurationRequest = @import("endpoint_configuration_request.zig").EndpointConfigurationRequest;
const PortalContent = @import("portal_content.zig").PortalContent;
const EndpointConfigurationResponse = @import("endpoint_configuration_response.zig").EndpointConfigurationResponse;
const PublishStatus = @import("publish_status.zig").PublishStatus;
const StatusException = @import("status_exception.zig").StatusException;

pub const CreatePortalInput = struct {
    /// The authentication configuration for the portal.
    authorization: Authorization,

    /// The domain configuration for the portal. Use a default domain provided by
    /// API Gateway or provide a fully-qualified domain name that you own.
    endpoint_configuration: EndpointConfigurationRequest,

    /// The ARNs of the portal products included in the portal.
    included_portal_product_arns: ?[]const []const u8 = null,

    /// The URI for the portal logo image that is displayed in the portal header.
    logo_uri: ?[]const u8 = null,

    /// The content of the portal.
    portal_content: PortalContent,

    /// The name of the Amazon CloudWatch RUM app monitor for the portal.
    rum_app_monitor_name: ?[]const u8 = null,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .authorization = "Authorization",
        .endpoint_configuration = "EndpointConfiguration",
        .included_portal_product_arns = "IncludedPortalProductArns",
        .logo_uri = "LogoUri",
        .portal_content = "PortalContent",
        .rum_app_monitor_name = "RumAppMonitorName",
        .tags = "Tags",
    };
};

pub const CreatePortalOutput = struct {
    /// The authorization for the portal. Supports Cognito-based user authentication
    /// or no authentication.
    authorization: ?Authorization = null,

    /// The endpoint configuration.
    endpoint_configuration: ?EndpointConfigurationResponse = null,

    /// The ARNs of the portal products included in the portal.
    included_portal_product_arns: ?[]const []const u8 = null,

    /// The timestamp when the portal configuration was last modified.
    last_modified: ?i64 = null,

    /// The timestamp when the portal was last published.
    last_published: ?i64 = null,

    /// A user-written description of the changes made in the last published version
    /// of the portal.
    last_published_description: ?[]const u8 = null,

    /// The ARN of the portal.
    portal_arn: ?[]const u8 = null,

    /// The name, description, and theme for the portal.
    portal_content: ?PortalContent = null,

    /// The portal identifier.
    portal_id: ?[]const u8 = null,

    /// The current publishing status of the portal.
    publish_status: ?PublishStatus = null,

    /// The name of the Amazon CloudWatch RUM app monitor.
    rum_app_monitor_name: ?[]const u8 = null,

    /// Error information for failed portal operations. Contains details about any
    /// issues encountered during portal creation or publishing.
    status_exception: ?StatusException = null,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .authorization = "Authorization",
        .endpoint_configuration = "EndpointConfiguration",
        .included_portal_product_arns = "IncludedPortalProductArns",
        .last_modified = "LastModified",
        .last_published = "LastPublished",
        .last_published_description = "LastPublishedDescription",
        .portal_arn = "PortalArn",
        .portal_content = "PortalContent",
        .portal_id = "PortalId",
        .publish_status = "PublishStatus",
        .rum_app_monitor_name = "RumAppMonitorName",
        .status_exception = "StatusException",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePortalInput, options: CallOptions) !CreatePortalOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePortalInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/portals";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Authorization\":");
    try aws.json.writeValue(@TypeOf(input.authorization), input.authorization, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EndpointConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.endpoint_configuration), input.endpoint_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.included_portal_product_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncludedPortalProductArns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.logo_uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LogoUri\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PortalContent\":");
    try aws.json.writeValue(@TypeOf(input.portal_content), input.portal_content, allocator, &body_buf);
    has_prev = true;
    if (input.rum_app_monitor_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RumAppMonitorName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePortalOutput {
    const result: CreatePortalOutput = try aws.json.parseJsonObject(
        CreatePortalOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
