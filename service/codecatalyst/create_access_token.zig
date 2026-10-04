const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateAccessTokenInput = struct {
    /// The date and time the personal access token expires, in coordinated
    /// universal time (UTC) timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6).
    expires_time: ?i64 = null,

    /// The friendly name of the personal access token.
    name: []const u8,

    pub const json_field_names = .{
        .expires_time = "expiresTime",
        .name = "name",
    };
};

pub const CreateAccessTokenOutput = struct {
    /// The system-generated unique ID of the access token.
    access_token_id: []const u8,

    /// The date and time the personal access token expires, in coordinated
    /// universal time (UTC) timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6). If not specified,
    /// the default is one year from creation.
    expires_time: i64,

    /// The friendly name of the personal access token.
    name: []const u8,

    /// The secret value of the personal access token.
    secret: []const u8,

    pub const json_field_names = .{
        .access_token_id = "accessTokenId",
        .expires_time = "expiresTime",
        .name = "name",
        .secret = "secret",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAccessTokenInput, options: CallOptions) !CreateAccessTokenOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codecatalyst", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAccessTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecatalyst", "CodeCatalyst", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/accessTokens";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.expires_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"expiresTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAccessTokenOutput {
    const result: CreateAccessTokenOutput = try aws.json.parseJsonObject(
        CreateAccessTokenOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
