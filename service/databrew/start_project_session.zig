const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartProjectSessionInput = struct {
    /// A value that, if true, enables you to take control of a session, even if a
    /// different
    /// client is currently accessing the project.
    assume_control: ?bool = null,

    /// The name of the project to act upon.
    name: []const u8,

    pub const json_field_names = .{
        .assume_control = "AssumeControl",
        .name = "Name",
    };
};

pub const StartProjectSessionOutput = struct {
    /// A system-generated identifier for the session.
    client_session_id: ?[]const u8 = null,

    /// The name of the project to be acted upon.
    name: []const u8,

    pub const json_field_names = .{
        .client_session_id = "ClientSessionId",
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartProjectSessionInput, options: CallOptions) !StartProjectSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "databrew", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartProjectSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("databrew", "DataBrew", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/projects/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/startProjectSession");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.assume_control) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AssumeControl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartProjectSessionOutput {
    var result: StartProjectSessionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartProjectSessionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
