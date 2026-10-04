const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RevocationMode = @import("revocation_mode.zig").RevocationMode;

pub const RevokeStreamUrlInput = struct {
    /// An [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// or ID that uniquely identifies the stream group resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamgroup/sg-1AB2C3De4`.
    /// Example ID: `sg-1AB2C3De4`.
    ///
    /// This is the stream group that owns the stream URL.
    identifier: []const u8,

    /// Controls what happens to running stream sessions when you revoke the stream
    /// URL. If you do not specify a value, the default is `REVOKE_URL`. Possible
    /// values include the following:
    ///
    /// * `REVOKE_URL`: Stops the stream URL from starting new stream sessions.
    ///   Running sessions continue until they end.
    /// * `REVOKE_AND_TERMINATE_SESSIONS`: Stops new stream sessions and ends any
    ///   running stream sessions.
    revocation_mode: ?RevocationMode = null,

    /// The unique identifier of the stream URL to revoke. Specify a stream URL ID
    /// or Amazon Resource Name (ARN). Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamurl/sg-1AB2C3De4/su-1AB2C3De4`. Example ID: `su-1AB2C3De4`.
    stream_url_identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .revocation_mode = "RevocationMode",
        .stream_url_identifier = "StreamUrlIdentifier",
    };
};

pub const RevokeStreamUrlOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RevokeStreamUrlInput, options: CallOptions) !RevokeStreamUrlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gameliftstreams", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RevokeStreamUrlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gameliftstreams", "GameLiftStreams", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/streamgroups/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/streamurls/");
    try path_buf.appendSlice(allocator, input.stream_url_identifier);
    try path_buf.appendSlice(allocator, "/revoke");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.revocation_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RevocationMode\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RevokeStreamUrlOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: RevokeStreamUrlOutput = .{};

    return result;
}
