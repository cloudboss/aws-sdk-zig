const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetConsoleAuthorizationConfigurationInput = struct {
    /// Target account identifier
    target_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .target_id = "targetId",
    };
};

pub const GetConsoleAuthorizationConfigurationOutput = struct {
    /// Whether console authorization is enabled
    console_authorization_enabled: bool,

    /// Authorization scope
    scope: []const u8,

    /// Target account identifier
    target_id: []const u8,

    pub const json_field_names = .{
        .console_authorization_enabled = "consoleAuthorizationEnabled",
        .scope = "scope",
        .target_id = "targetId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConsoleAuthorizationConfigurationInput, options: CallOptions) !GetConsoleAuthorizationConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "signin", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConsoleAuthorizationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("signin", "Signin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/get-console-authorization-configuration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.target_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"targetId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConsoleAuthorizationConfigurationOutput {
    const result: GetConsoleAuthorizationConfigurationOutput = try aws.json.parseJsonObject(
        GetConsoleAuthorizationConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
