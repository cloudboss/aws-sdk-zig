const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServiceEnvironmentInput, options: Options) !CreateServiceEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "batch");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateServiceEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/createserviceenvironment";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"capacityLimits\":");
    try aws.json.writeValue(@TypeOf(input.capacity_limits), input.capacity_limits, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"serviceEnvironmentName\":");
    try aws.json.writeValue(@TypeOf(input.service_environment_name), input.service_environment_name, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"serviceEnvironmentType\":");
    try aws.json.writeValue(@TypeOf(input.service_environment_type), input.service_environment_type, alloc, &body_buf);
    has_prev = true;
    if (input.state) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"state\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tags\":");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateServiceEnvironmentOutput {
    var result: CreateServiceEnvironmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateServiceEnvironmentOutput, body, alloc);
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
