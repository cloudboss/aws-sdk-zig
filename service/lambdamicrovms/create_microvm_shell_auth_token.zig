const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateMicrovmShellAuthTokenInput = struct {
    /// The duration in minutes before the shell authentication token expires.
    expiration_in_minutes: i32,

    /// The ID of the MicroVM to create a shell authentication token for.
    microvm_identifier: []const u8,

    pub const json_field_names = .{
        .expiration_in_minutes = "expirationInMinutes",
        .microvm_identifier = "microvmIdentifier",
    };
};

pub const CreateMicrovmShellAuthTokenOutput = struct {
    /// The generated shell authentication token key-value pairs for accessing the
    /// MicroVM.
    auth_token: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .auth_token = "authToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMicrovmShellAuthTokenInput, options: CallOptions) !CreateMicrovmShellAuthTokenOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMicrovmShellAuthTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda Microvms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-09-09/microvms/");
    try path_buf.appendSlice(allocator, input.microvm_identifier);
    try path_buf.appendSlice(allocator, "/shell-auth-token");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"expirationInMinutes\":");
    try aws.json.writeValue(@TypeOf(input.expiration_in_minutes), input.expiration_in_minutes, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMicrovmShellAuthTokenOutput {
    const result: CreateMicrovmShellAuthTokenOutput = try aws.json.parseJsonObject(
        CreateMicrovmShellAuthTokenOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
