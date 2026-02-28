const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ApplicationConfig = @import("application_config.zig").ApplicationConfig;
const ApplicationSourceConfig = @import("application_source_config.zig").ApplicationSourceConfig;
const ApplicationType = @import("application_type.zig").ApplicationType;
const IframeConfig = @import("iframe_config.zig").IframeConfig;
const Publication = @import("publication.zig").Publication;
const Subscription = @import("subscription.zig").Subscription;

pub const GetApplicationInput = struct {
    /// The Amazon Resource Name (ARN) of the Application.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub const GetApplicationOutput = struct {
    /// The configuration settings for the application.
    application_config: ?ApplicationConfig = null,

    /// The configuration for where the application should be loaded from.
    application_source_config: ?ApplicationSourceConfig = null,

    /// The type of application.
    application_type: ?ApplicationType = null,

    /// The Amazon Resource Name (ARN) of the Application.
    arn: ?[]const u8 = null,

    /// The created time of the Application.
    created_time: ?i64 = null,

    /// The description of the application.
    description: ?[]const u8 = null,

    /// A unique identifier for the Application.
    id: ?[]const u8 = null,

    /// The iframe configuration for the application.
    iframe_config: ?IframeConfig = null,

    /// The maximum time in milliseconds allowed to establish a connection with the
    /// workspace.
    initialization_timeout: ?i32 = null,

    /// Indicates whether the application is a service.
    is_service: ?bool = null,

    /// The last modified time of the Application.
    last_modified_time: ?i64 = null,

    /// The name of the application.
    name: ?[]const u8 = null,

    /// The namespace of the application.
    namespace: ?[]const u8 = null,

    /// The configuration of events or requests that the application has access to.
    permissions: ?[]const []const u8 = null,

    /// The events that the application publishes.
    publications: ?[]const Publication = null,

    /// The events that the application subscribes.
    subscriptions: ?[]const Subscription = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .application_config = "ApplicationConfig",
        .application_source_config = "ApplicationSourceConfig",
        .application_type = "ApplicationType",
        .arn = "Arn",
        .created_time = "CreatedTime",
        .description = "Description",
        .id = "Id",
        .iframe_config = "IframeConfig",
        .initialization_timeout = "InitializationTimeout",
        .is_service = "IsService",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .namespace = "Namespace",
        .permissions = "Permissions",
        .publications = "Publications",
        .subscriptions = "Subscriptions",
        .tags = "Tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetApplicationInput, options: Options) !GetApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "appintegrations");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appintegrations", "AppIntegrations", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/applications/");
    try path_buf.appendSlice(alloc, input.arn);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetApplicationOutput {
    var result: GetApplicationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetApplicationOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "DuplicateResourceException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_resource_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
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
