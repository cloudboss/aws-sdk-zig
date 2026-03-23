const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CapacityLimit = @import("capacity_limit.zig").CapacityLimit;
const ServiceEnvironmentType = @import("service_environment_type.zig").ServiceEnvironmentType;
const ServiceEnvironmentState = @import("service_environment_state.zig").ServiceEnvironmentState;

pub const CreateServiceEnvironmentInput = struct {
    /// The capacity limits for the service environment. The number of instances a
    /// job consumes is the total number of instances requested in the submit
    /// training job request resource configuration.
    capacity_limits: []const CapacityLimit,

    /// The name for the service environment. It can be up to 128 characters long
    /// and can contain letters, numbers, hyphens (-), and underscores (_).
    service_environment_name: []const u8,

    /// The type of service environment. For SageMaker Training jobs, specify
    /// `SAGEMAKER_TRAINING`.
    service_environment_type: ServiceEnvironmentType,

    /// The state of the service environment. Valid values are `ENABLED` and
    /// `DISABLED`. The default value is `ENABLED`.
    state: ?ServiceEnvironmentState = null,

    /// The tags that you apply to the service environment to help you categorize
    /// and organize your resources. Each tag consists of a key and an optional
    /// value. For more information, see [Tagging your Batch
    /// resources](https://docs.aws.amazon.com/batch/latest/userguide/using-tags.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .capacity_limits = "capacityLimits",
        .service_environment_name = "serviceEnvironmentName",
        .service_environment_type = "serviceEnvironmentType",
        .state = "state",
        .tags = "tags",
    };
};

pub const CreateServiceEnvironmentOutput = struct {
    /// The Amazon Resource Name (ARN) of the service environment.
    service_environment_arn: []const u8,

    /// The name of the service environment.
    service_environment_name: []const u8,

    pub const json_field_names = .{
        .service_environment_arn = "serviceEnvironmentArn",
        .service_environment_name = "serviceEnvironmentName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServiceEnvironmentInput, options: CallOptions) !CreateServiceEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "batch");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateServiceEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/createserviceenvironment";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"capacityLimits\":");
    try aws.json.writeValue(@TypeOf(input.capacity_limits), input.capacity_limits, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"serviceEnvironmentName\":");
    try aws.json.writeValue(@TypeOf(input.service_environment_name), input.service_environment_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"serviceEnvironmentType\":");
    try aws.json.writeValue(@TypeOf(input.service_environment_type), input.service_environment_type, allocator, &body_buf);
    has_prev = true;
    if (input.state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"state\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateServiceEnvironmentOutput {
    var result: CreateServiceEnvironmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateServiceEnvironmentOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ClientException")) {
        return .{ .arena = arena, .kind = .{ .client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerException")) {
        return .{ .arena = arena, .kind = .{ .server_exception = .{
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
