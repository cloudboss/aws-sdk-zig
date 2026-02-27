const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DefaultRouteInput = @import("default_route_input.zig").DefaultRouteInput;
const RouteType = @import("route_type.zig").RouteType;
const UriPathRouteInput = @import("uri_path_route_input.zig").UriPathRouteInput;
const RouteState = @import("route_state.zig").RouteState;

pub const CreateRouteInput = struct {
    /// The ID of the application within which the route is being created.
    application_identifier: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request.
    client_token: ?[]const u8 = null,

    /// Configuration for the default route type.
    default_route: ?DefaultRouteInput = null,

    /// The ID of the environment in which the route is created.
    environment_identifier: []const u8,

    /// The route type of the route. `DEFAULT` indicates that all traffic that does
    /// not
    /// match another route is forwarded to the default route. Applications must
    /// have a default route
    /// before any other routes can be created. `URI_PATH` indicates a route that is
    /// based
    /// on a URI path.
    route_type: RouteType,

    /// The ID of the service in which the route is created. Traffic that matches
    /// this route is
    /// forwarded to this service.
    service_identifier: []const u8,

    /// The tags to assign to the route. A tag is a label that you assign to an
    /// Amazon Web Services resource. Each tag consists of a key-value pair..
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The configuration for the URI path route type.
    uri_path_route: ?UriPathRouteInput = null,

    pub const json_field_names = .{
        .application_identifier = "ApplicationIdentifier",
        .client_token = "ClientToken",
        .default_route = "DefaultRoute",
        .environment_identifier = "EnvironmentIdentifier",
        .route_type = "RouteType",
        .service_identifier = "ServiceIdentifier",
        .tags = "Tags",
        .uri_path_route = "UriPathRoute",
    };
};

pub const CreateRouteOutput = struct {
    /// The ID of the application in which the route is created.
    application_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the route. The format for this ARN is
    /// `arn:aws:refactor-spaces:*region*:*account-id*:*resource-type/resource-id*
    /// `. For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference*.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the route creator.
    created_by_account_id: ?[]const u8 = null,

    /// A timestamp that indicates when the route is created.
    created_time: ?i64 = null,

    /// A timestamp that indicates when the route was last updated.
    last_updated_time: ?i64 = null,

    /// The Amazon Web Services account ID of the route owner.
    owner_account_id: ?[]const u8 = null,

    /// The unique identifier of the route.
    route_id: ?[]const u8 = null,

    /// The route type of the route.
    route_type: ?RouteType = null,

    /// The ID of service in which the route is created. Traffic that matches this
    /// route is
    /// forwarded to this service.
    service_id: ?[]const u8 = null,

    /// The current state of the route. Activation state only allows `ACTIVE` or
    /// `INACTIVE` as user inputs. `FAILED` is a route state that is system
    /// generated.
    state: ?RouteState = null,

    /// The tags assigned to the created route. A tag is a label that you assign to
    /// an Amazon Web Services resource. Each tag consists of a key-value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Configuration for the URI path route type.
    uri_path_route: ?UriPathRouteInput = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .arn = "Arn",
        .created_by_account_id = "CreatedByAccountId",
        .created_time = "CreatedTime",
        .last_updated_time = "LastUpdatedTime",
        .owner_account_id = "OwnerAccountId",
        .route_id = "RouteId",
        .route_type = "RouteType",
        .service_id = "ServiceId",
        .state = "State",
        .tags = "Tags",
        .uri_path_route = "UriPathRoute",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRouteInput, options: Options) !CreateRouteOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateRouteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhubrefactorspaces", "Migration Hub Refactor Spaces", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/environments/");
    try path_buf.appendSlice(alloc, input.environment_identifier);
    try path_buf.appendSlice(alloc, "/applications/");
    try path_buf.appendSlice(alloc, input.application_identifier);
    try path_buf.appendSlice(alloc, "/routes");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.default_route) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DefaultRoute\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"RouteType\":");
    try aws.json.writeValue(@TypeOf(input.route_type), input.route_type, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"ServiceIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.service_identifier), input.service_identifier, alloc, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.uri_path_route) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"UriPathRoute\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateRouteOutput {
    var result: CreateRouteOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateRouteOutput, body, alloc);
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
