const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ApiGatewayProxyInput = @import("api_gateway_proxy_input.zig").ApiGatewayProxyInput;
const ProxyType = @import("proxy_type.zig").ProxyType;
const ApplicationState = @import("application_state.zig").ApplicationState;

pub const CreateApplicationInput = struct {
    /// A wrapper object holding the API Gateway endpoint type and stage name for
    /// the
    /// proxy.
    api_gateway_proxy: ?ApiGatewayProxyInput = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request.
    client_token: ?[]const u8 = null,

    /// The unique identifier of the environment.
    environment_identifier: []const u8,

    /// The name to use for the application.
    name: []const u8,

    /// The proxy type of the proxy created within the application.
    proxy_type: ProxyType,

    /// The tags to assign to the application. A tag is a label that you assign to
    /// an Amazon Web Services resource. Each tag consists of a key-value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the virtual private cloud (VPC).
    vpc_id: []const u8,

    pub const json_field_names = .{
        .api_gateway_proxy = "ApiGatewayProxy",
        .client_token = "ClientToken",
        .environment_identifier = "EnvironmentIdentifier",
        .name = "Name",
        .proxy_type = "ProxyType",
        .tags = "Tags",
        .vpc_id = "VpcId",
    };
};

pub const CreateApplicationOutput = struct {
    /// A wrapper object holding the API Gateway endpoint type and stage name for
    /// the
    /// proxy.
    api_gateway_proxy: ?ApiGatewayProxyInput = null,

    /// The unique identifier of the application.
    application_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the application. The format for this ARN
    /// is
    /// `arn:aws:refactor-spaces:*region*:*account-id*:*resource-type/resource-id*
    /// `. For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference*.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services account ID of application creator.
    created_by_account_id: ?[]const u8 = null,

    /// A timestamp that indicates when the application is created.
    created_time: ?i64 = null,

    /// The ID of the environment in which the application is created.
    environment_id: ?[]const u8 = null,

    /// A timestamp that indicates when the application was last updated.
    last_updated_time: ?i64 = null,

    /// The name of the application.
    name: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the application owner (which is always
    /// the same as
    /// the environment owner account ID).
    owner_account_id: ?[]const u8 = null,

    /// The proxy type of the proxy created within the application.
    proxy_type: ?ProxyType = null,

    /// The current state of the application.
    state: ?ApplicationState = null,

    /// The tags assigned to the application. A tag is a label that you assign to an
    /// Amazon Web Services resource. Each tag consists of a key-value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the Amazon VPC.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_gateway_proxy = "ApiGatewayProxy",
        .application_id = "ApplicationId",
        .arn = "Arn",
        .created_by_account_id = "CreatedByAccountId",
        .created_time = "CreatedTime",
        .environment_id = "EnvironmentId",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .owner_account_id = "OwnerAccountId",
        .proxy_type = "ProxyType",
        .state = "State",
        .tags = "Tags",
        .vpc_id = "VpcId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApplicationInput, options: Options) !CreateApplicationOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhubrefactorspaces", "Migration Hub Refactor Spaces", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.environment_identifier);
    try path_buf.appendSlice(allocator, "/applications");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.api_gateway_proxy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ApiGatewayProxy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ProxyType\":");
    try aws.json.writeValue(@TypeOf(input.proxy_type), input.proxy_type, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"VpcId\":");
    try aws.json.writeValue(@TypeOf(input.vpc_id), input.vpc_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApplicationOutput {
    var result: CreateApplicationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateApplicationOutput, body, allocator);
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
