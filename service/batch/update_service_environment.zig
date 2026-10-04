const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapacityLimit = @import("capacity_limit.zig").CapacityLimit;
const ServiceEnvironmentState = @import("service_environment_state.zig").ServiceEnvironmentState;

pub const UpdateServiceEnvironmentInput = struct {
    /// The capacity limits for the service environment. This defines the maximum
    /// resources that can be used by service jobs in this environment.
    capacity_limits: ?[]const CapacityLimit = null,

    /// The name or ARN of the service environment to update.
    service_environment: []const u8,

    /// The state of the service environment.
    state: ?ServiceEnvironmentState = null,

    pub const json_field_names = .{
        .capacity_limits = "capacityLimits",
        .service_environment = "serviceEnvironment",
        .state = "state",
    };
};

pub const UpdateServiceEnvironmentOutput = struct {
    /// The Amazon Resource Name (ARN) of the service environment that was updated.
    service_environment_arn: []const u8,

    /// The name of the service environment that was updated.
    service_environment_name: []const u8,

    pub const json_field_names = .{
        .service_environment_arn = "serviceEnvironmentArn",
        .service_environment_name = "serviceEnvironmentName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateServiceEnvironmentInput, options: CallOptions) !UpdateServiceEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "batch", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateServiceEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/updateserviceenvironment";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.capacity_limits) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"capacityLimits\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"serviceEnvironment\":");
    try aws.json.writeValue(@TypeOf(input.service_environment), input.service_environment, allocator, &body_buf);
    has_prev = true;
    if (input.state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"state\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateServiceEnvironmentOutput {
    const result: UpdateServiceEnvironmentOutput = try aws.json.parseJsonObject(
        UpdateServiceEnvironmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
