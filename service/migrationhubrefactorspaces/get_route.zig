const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ErrorResponse = @import("error_response.zig").ErrorResponse;
const HttpMethod = @import("http_method.zig").HttpMethod;
const RouteType = @import("route_type.zig").RouteType;
const RouteState = @import("route_state.zig").RouteState;

pub const GetRouteInput = struct {
    /// The ID of the application.
    application_identifier: []const u8,

    /// The ID of the environment.
    environment_identifier: []const u8,

    /// The ID of the route.
    route_identifier: []const u8,

    pub const json_field_names = .{
        .application_identifier = "ApplicationIdentifier",
        .environment_identifier = "EnvironmentIdentifier",
        .route_identifier = "RouteIdentifier",
    };
};

pub const GetRouteOutput = struct {
    /// If set to `true`, this option appends the source path to the service URL
    /// endpoint.
    append_source_path: ?bool = null,

    /// The ID of the application that the route belongs to.
    application_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the route.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the route creator.
    created_by_account_id: ?[]const u8 = null,

    /// The timestamp of when the route is created.
    created_time: ?i64 = null,

    /// Unique identifier of the environment.
    environment_id: ?[]const u8 = null,

    /// Any error associated with the route resource.
    @"error": ?ErrorResponse = null,

    /// Indicates whether to match all subpaths of the given source path. If this
    /// value is
    /// `false`, requests must match the source path exactly before they are
    /// forwarded to
    /// this route's service.
    include_child_paths: ?bool = null,

    /// A timestamp that indicates when the route was last updated.
    last_updated_time: ?i64 = null,

    /// A list of HTTP methods to match. An empty list matches all values. If a
    /// method is present,
    /// only HTTP requests using that method are forwarded to this route’s service.
    methods: ?[]const HttpMethod = null,

    /// The Amazon Web Services account ID of the route owner.
    owner_account_id: ?[]const u8 = null,

    /// A mapping of Amazon API Gateway path resources to resource IDs.
    path_resource_to_id: ?[]const aws.map.StringMapEntry = null,

    /// The unique identifier of the route.
    ///
    /// **DEFAULT**: All traffic that does not match another route is
    /// forwarded to the default route. Applications must have a default route
    /// before any other routes
    /// can be created.
    ///
    /// **URI_PATH**: A route that is based on a URI path.
    route_id: ?[]const u8 = null,

    /// The type of route.
    route_type: ?RouteType = null,

    /// The unique identifier of the service.
    service_id: ?[]const u8 = null,

    /// This is the path that Refactor Spaces uses to match traffic. Paths must
    /// start with `/` and are relative to
    /// the base of the application. To use path parameters in the source path, add
    /// a variable in curly braces.
    /// For example, the resource path {user} represents a path parameter called
    /// 'user'.
    source_path: ?[]const u8 = null,

    /// The current state of the route.
    state: ?RouteState = null,

    /// The tags assigned to the route. A tag is a label that you assign to an
    /// Amazon Web Services resource. Each tag consists of a key-value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .append_source_path = "AppendSourcePath",
        .application_id = "ApplicationId",
        .arn = "Arn",
        .created_by_account_id = "CreatedByAccountId",
        .created_time = "CreatedTime",
        .environment_id = "EnvironmentId",
        .@"error" = "Error",
        .include_child_paths = "IncludeChildPaths",
        .last_updated_time = "LastUpdatedTime",
        .methods = "Methods",
        .owner_account_id = "OwnerAccountId",
        .path_resource_to_id = "PathResourceToId",
        .route_id = "RouteId",
        .route_type = "RouteType",
        .service_id = "ServiceId",
        .source_path = "SourcePath",
        .state = "State",
        .tags = "Tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRouteInput, options: Options) !GetRouteOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "migrationhubrefactorspaces");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetRouteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhubrefactorspaces", "Migration Hub Refactor Spaces", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/environments/");
    try path_buf.appendSlice(alloc, input.environment_identifier);
    try path_buf.appendSlice(alloc, "/applications/");
    try path_buf.appendSlice(alloc, input.application_identifier);
    try path_buf.appendSlice(alloc, "/routes/");
    try path_buf.appendSlice(alloc, input.route_identifier);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetRouteOutput {
    var result: GetRouteOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRouteOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourcePolicyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_policy_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
