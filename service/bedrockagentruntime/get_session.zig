const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SessionStatus = @import("session_status.zig").SessionStatus;

pub const GetSessionInput = struct {
    /// A unique identifier for the session to retrieve. You can specify either the
    /// session's `sessionId` or its Amazon Resource Name (ARN).
    session_identifier: []const u8,

    pub const json_field_names = .{
        .session_identifier = "sessionIdentifier",
    };
};

pub const GetSessionOutput = struct {
    /// The timestamp for when the session was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the Key Management Service key used to
    /// encrypt the session data. For more information, see [Amazon Bedrock session
    /// encryption](https://docs.aws.amazon.com/bedrock/latest/userguide/session-encryption.html).
    encryption_key_arn: ?[]const u8 = null,

    /// The timestamp for when the session was last modified.
    last_updated_at: i64,

    /// The Amazon Resource Name (ARN) of the session.
    session_arn: []const u8,

    /// The unique identifier for the session in UUID format.
    session_id: []const u8,

    /// A map of key-value pairs containing attributes persisted across the session.
    session_metadata: ?[]const aws.map.StringMapEntry = null,

    /// The current status of the session.
    session_status: SessionStatus,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .encryption_key_arn = "encryptionKeyArn",
        .last_updated_at = "lastUpdatedAt",
        .session_arn = "sessionArn",
        .session_id = "sessionId",
        .session_metadata = "sessionMetadata",
        .session_status = "sessionStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSessionInput, options: CallOptions) !GetSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent-runtime", "Bedrock Agent Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sessions/");
    try path_buf.appendSlice(allocator, input.session_identifier);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSessionOutput {
    var result: GetSessionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSessionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
