const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteConnectionRecordingPreferencesInput = struct {
    /// User-provided idempotency token.
    client_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
    };
};

pub const DeleteConnectionRecordingPreferencesOutput = struct {
    /// Service-provided idempotency token.
    client_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteConnectionRecordingPreferencesInput, options: CallOptions) !DeleteConnectionRecordingPreferencesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-guiconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteConnectionRecordingPreferencesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-guiconnect", "SSM GuiConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/DeleteConnectionRecordingPreferences";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteConnectionRecordingPreferencesOutput {
    var result: DeleteConnectionRecordingPreferencesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteConnectionRecordingPreferencesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
