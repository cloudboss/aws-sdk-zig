const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CardValue = @import("card_value.zig").CardValue;

pub const UpdateQAppSessionInput = struct {
    /// The unique identifier of the Amazon Q Business application environment
    /// instance.
    instance_id: []const u8,

    /// The unique identifier of the Q App session to provide input for.
    session_id: []const u8,

    /// The input values to provide for the current state of the Q App session.
    values: ?[]const CardValue = null,

    pub const json_field_names = .{
        .instance_id = "instanceId",
        .session_id = "sessionId",
        .values = "values",
    };
};

pub const UpdateQAppSessionOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated Q App session.
    session_arn: []const u8,

    /// The unique identifier of the updated Q App session.
    session_id: []const u8,

    pub const json_field_names = .{
        .session_arn = "sessionArn",
        .session_id = "sessionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateQAppSessionInput, options: CallOptions) !UpdateQAppSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateQAppSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.qapps", "QApps", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/runtime.updateQAppSession";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sessionId\":");
    try aws.json.writeValue(@TypeOf(input.session_id), input.session_id, allocator, &body_buf);
    has_prev = true;
    if (input.values) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"values\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateQAppSessionOutput {
    var result: UpdateQAppSessionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateQAppSessionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
