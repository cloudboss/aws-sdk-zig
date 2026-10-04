const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Command = @import("command.zig").Command;

pub const CreateTaskInput = struct {
    /// A token ensuring that the action is called only once with the specified
    /// details.
    client_token: ?[]const u8 = null,

    /// The task to be performed. Only one task is executed on a device at a time.
    command: Command,

    /// A description of the task and its targets.
    description: ?[]const u8 = null,

    /// Optional metadata that you assign to a resource. You can use tags to
    /// categorize a resource
    /// in different ways, such as by purpose, owner, or environment.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A list of managed device IDs.
    targets: []const []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .command = "command",
        .description = "description",
        .tags = "tags",
        .targets = "targets",
    };
};

pub const CreateTaskOutput = struct {
    /// The Amazon Resource Name (ARN) of the task that you created.
    task_arn: ?[]const u8 = null,

    /// The ID of the task that you created.
    task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .task_arn = "taskArn",
        .task_id = "taskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTaskInput, options: CallOptions) !CreateTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "snow-device-management", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("snow-device-management", "Snow Device Management", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/task";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"command\":");
    try aws.json.writeValue(@TypeOf(input.command), input.command, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targets\":");
    try aws.json.writeValue(@TypeOf(input.targets), input.targets, allocator, &body_buf);
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTaskOutput {
    var result: CreateTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateTaskOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
