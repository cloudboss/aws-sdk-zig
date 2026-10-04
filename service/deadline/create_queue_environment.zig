const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentTemplateType = @import("environment_template_type.zig").EnvironmentTemplateType;

pub const CreateQueueEnvironmentInput = struct {
    /// The unique token which the server uses to recognize retries of the same
    /// request.
    client_token: ?[]const u8 = null,

    /// The farm ID of the farm to connect to the environment.
    farm_id: []const u8,

    /// Sets the priority of the environments in the queue from 0 to 10,000, where 0
    /// is the highest priority (activated first and deactivated last). If two
    /// environments share the same priority value, the environment created first
    /// takes higher priority.
    priority: i32,

    /// The queue ID to connect the queue and environment.
    queue_id: []const u8,

    /// The environment template to use in the queue.
    template: []const u8,

    /// The template's file type, `JSON` or `YAML`.
    template_type: EnvironmentTemplateType,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .farm_id = "farmId",
        .priority = "priority",
        .queue_id = "queueId",
        .template = "template",
        .template_type = "templateType",
    };
};

pub const CreateQueueEnvironmentOutput = struct {
    /// The queue environment ID.
    queue_environment_id: []const u8,

    pub const json_field_names = .{
        .queue_environment_id = "queueEnvironmentId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateQueueEnvironmentInput, options: CallOptions) !CreateQueueEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "deadline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateQueueEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2023-10-12/farms/");
    try path_buf.appendSlice(allocator, input.farm_id);
    try path_buf.appendSlice(allocator, "/queues/");
    try path_buf.appendSlice(allocator, input.queue_id);
    try path_buf.appendSlice(allocator, "/environments");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"priority\":");
    try aws.json.writeValue(@TypeOf(input.priority), input.priority, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"template\":");
    try aws.json.writeValue(@TypeOf(input.template), input.template, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"templateType\":");
    try aws.json.writeValue(@TypeOf(input.template_type), input.template_type, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.client_token) |v| {
        try request.headers.put(allocator, "X-Amz-Client-Token", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateQueueEnvironmentOutput {
    const result: CreateQueueEnvironmentOutput = try aws.json.parseJsonObject(
        CreateQueueEnvironmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
