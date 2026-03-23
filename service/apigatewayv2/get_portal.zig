const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Authorization = @import("authorization.zig").Authorization;
const EndpointConfigurationResponse = @import("endpoint_configuration_response.zig").EndpointConfigurationResponse;
const PortalContent = @import("portal_content.zig").PortalContent;
const Preview = @import("preview.zig").Preview;
const PublishStatus = @import("publish_status.zig").PublishStatus;
const StatusException = @import("status_exception.zig").StatusException;

pub const GetPortalInput = struct {
    /// The portal identifier.
    portal_id: []const u8,

    pub const json_field_names = .{
        .portal_id = "PortalId",
    };
};

pub const GetPortalOutput = struct {
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

    /// The publish description used when the portal was last published.
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

    /// The publish status of a portal.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPortalInput, options: CallOptions) !GetPortalOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "apigateway");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetPortalInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v2/portals/");
    try path_buf.appendSlice(allocator, input.portal_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPortalOutput {
    var result: GetPortalOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetPortalOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
