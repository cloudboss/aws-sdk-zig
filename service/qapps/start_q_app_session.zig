const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CardValue = @import("card_value.zig").CardValue;

pub const StartQAppSessionInput = struct {
    /// The unique identifier of the Q App to start a session for.
    app_id: []const u8,

    /// The version of the Q App to use for the session.
    app_version: i32,

    /// Optional initial input values to provide for the Q App session.
    initial_values: ?[]const CardValue = null,

    /// The unique identifier of the Amazon Q Business application environment
    /// instance.
    instance_id: []const u8,

    /// The unique identifier of the a Q App session.
    session_id: ?[]const u8 = null,

    /// Optional tags to associate with the new Q App session.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .app_id = "appId",
        .app_version = "appVersion",
        .initial_values = "initialValues",
        .instance_id = "instanceId",
        .session_id = "sessionId",
        .tags = "tags",
    };
};

pub const StartQAppSessionOutput = struct {
    /// The Amazon Resource Name (ARN) of the new Q App session.
    session_arn: []const u8,

    /// The unique identifier of the new or retrieved Q App session.
    session_id: []const u8,

    pub const json_field_names = .{
        .session_arn = "sessionArn",
        .session_id = "sessionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartQAppSessionInput, options: CallOptions) !StartQAppSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qapps", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartQAppSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.qapps", "QApps", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/runtime.startQAppSession";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"appId\":");
    try aws.json.writeValue(@TypeOf(input.app_id), input.app_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"appVersion\":");
    try aws.json.writeValue(@TypeOf(input.app_version), input.app_version, allocator, &body_buf);
    has_prev = true;
    if (input.initial_values) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"initialValues\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.session_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionId\":");
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "instance-id", input.instance_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartQAppSessionOutput {
    var result: StartQAppSessionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartQAppSessionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
