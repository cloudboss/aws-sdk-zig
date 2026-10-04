const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Authorization = @import("authorization.zig").Authorization;
const EndpointConfigurationRequest = @import("endpoint_configuration_request.zig").EndpointConfigurationRequest;
const PortalContent = @import("portal_content.zig").PortalContent;
const EndpointConfigurationResponse = @import("endpoint_configuration_response.zig").EndpointConfigurationResponse;
const Preview = @import("preview.zig").Preview;
const PublishStatus = @import("publish_status.zig").PublishStatus;
const StatusException = @import("status_exception.zig").StatusException;

pub const UpdatePortalInput = struct {
    /// The authorization of the portal.
    authorization: ?Authorization = null,

    /// Represents an endpoint configuration.
    endpoint_configuration: ?EndpointConfigurationRequest = null,

    /// The ARNs of the portal products included in the portal.
    included_portal_product_arns: ?[]const []const u8 = null,

    /// The logo URI.
    logo_uri: ?[]const u8 = null,

    /// Contains the content that is visible to portal consumers including the
    /// themes, display names, and description.
    portal_content: ?PortalContent = null,

    /// The portal identifier.
    portal_id: []const u8,

    /// The CloudWatch RUM app monitor name.
    rum_app_monitor_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorization = "Authorization",
        .endpoint_configuration = "EndpointConfiguration",
        .included_portal_product_arns = "IncludedPortalProductArns",
        .logo_uri = "LogoUri",
        .portal_content = "PortalContent",
        .portal_id = "PortalId",
        .rum_app_monitor_name = "RumAppMonitorName",
    };
};

pub const UpdatePortalOutput = struct {
    /// The authorization for the portal.
    authorization: ?Authorization = null,

    /// The endpoint configuration.
    endpoint_configuration: ?EndpointConfigurationResponse = null,

    /// The ARNs of the portal products included in the portal.
    included_portal_product_arns: ?[]const []const u8 = null,

    /// The timestamp when the portal was last modified.
    last_modified: ?i64 = null,

    /// The timestamp when the portal was last published.
    last_published: ?i64 = null,

    /// The description associated with the last time the portal was published.
    last_published_description: ?[]const u8 = null,

    /// The ARN of the portal.
    portal_arn: ?[]const u8 = null,

    /// Contains the content that is visible to portal consumers including the
    /// themes, display names, and description.
    portal_content: ?PortalContent = null,

    /// The portal identifier.
    portal_id: ?[]const u8 = null,

    /// Represents the preview endpoint and the any possible error messages during
    /// preview generation.
    preview: ?Preview = null,

    /// The publishStatus.
    publish_status: ?PublishStatus = null,

    /// The CloudWatch RUM app monitor name.
    rum_app_monitor_name: ?[]const u8 = null,

    /// The status exception information.
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
        .preview = "Preview",
        .publish_status = "PublishStatus",
        .rum_app_monitor_name = "RumAppMonitorName",
        .status_exception = "StatusException",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePortalInput, options: CallOptions) !UpdatePortalOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePortalInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/portals/");
    try path_buf.appendSlice(allocator, input.portal_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.authorization) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Authorization\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.endpoint_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EndpointConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.portal_content) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PortalContent\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.rum_app_monitor_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RumAppMonitorName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePortalOutput {
    var result: UpdatePortalOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdatePortalOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
