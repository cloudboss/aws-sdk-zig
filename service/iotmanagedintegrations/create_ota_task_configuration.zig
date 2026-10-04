const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PushConfig = @import("push_config.zig").PushConfig;

pub const CreateOtaTaskConfigurationInput = struct {
    /// An idempotency token. If you retry a request that completed successfully
    /// initially using the same client token and parameters, then the retry attempt
    /// will succeed without performing any further actions.
    client_token: ?[]const u8 = null,

    /// A description of the over-the-air (OTA) task configuration.
    description: ?[]const u8 = null,

    /// The name of the over-the-air (OTA) task.
    name: ?[]const u8 = null,

    /// Describes the type of configuration used for the over-the-air (OTA) task.
    push_config: ?PushConfig = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .name = "Name",
        .push_config = "PushConfig",
    };
};

pub const CreateOtaTaskConfigurationOutput = struct {
    /// The identifier of the over-the-air (OTA) task configuration.
    task_configuration_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .task_configuration_id = "TaskConfigurationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOtaTaskConfigurationInput, options: CallOptions) !CreateOtaTaskConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotmanagedintegrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOtaTaskConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ota-task-configurations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.push_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PushConfig\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOtaTaskConfigurationOutput {
    var result: CreateOtaTaskConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateOtaTaskConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
