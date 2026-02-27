const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePortalInput, options: Options) !UpdatePortalOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "apigatewayv2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdatePortalInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigatewayv2", "ApiGatewayV2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/v2/portals/");
    try path_buf.appendSlice(alloc, input.portal_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.authorization) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Authorization\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.endpoint_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"EndpointConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.included_portal_product_arns) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"IncludedPortalProductArns\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.logo_uri) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"LogoUri\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.portal_content) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"PortalContent\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.rum_app_monitor_name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"RumAppMonitorName\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdatePortalOutput {
    var result: UpdatePortalOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdatePortalOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
