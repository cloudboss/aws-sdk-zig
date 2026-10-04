const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Monitor = @import("monitor.zig").Monitor;
const EnvironmentState = @import("environment_state.zig").EnvironmentState;

pub const CreateEnvironmentInput = struct {
    /// The application ID.
    application_id: []const u8,

    /// A description of the environment.
    description: ?[]const u8 = null,

    /// Amazon CloudWatch alarms to monitor during the deployment process.
    monitors: ?[]const Monitor = null,

    /// A name for the environment.
    name: []const u8,

    /// Metadata to assign to the environment. Tags help organize and categorize
    /// your AppConfig resources. Each tag consists of a key and an optional value,
    /// both of which
    /// you define.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .description = "Description",
        .monitors = "Monitors",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateEnvironmentOutput = @import("environment.zig").Environment;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEnvironmentInput, options: CallOptions) !CreateEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appconfig", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfig", "AppConfig", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/environments");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.monitors) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Monitors\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEnvironmentOutput {
    var result: CreateEnvironmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateEnvironmentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
