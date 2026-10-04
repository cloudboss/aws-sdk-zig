const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SessionStatus = @import("session_status.zig").SessionStatus;

pub const CreateSessionInput = struct {
    /// The Amazon Resource Name (ARN) of the KMS key to use to encrypt the session
    /// data. The user or role creating the session must have permission to use the
    /// key. For more information, see [Amazon Bedrock session
    /// encryption](https://docs.aws.amazon.com/bedrock/latest/userguide/session-encryption.html).
    encryption_key_arn: ?[]const u8 = null,

    /// A map of key-value pairs containing attributes to be persisted across the
    /// session. For example, the user's ID, their language preference, and the type
    /// of device they are using.
    session_metadata: ?[]const aws.map.StringMapEntry = null,

    /// Specify the key-value pairs for the tags that you want to attach to the
    /// session.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .encryption_key_arn = "encryptionKeyArn",
        .session_metadata = "sessionMetadata",
        .tags = "tags",
    };
};

pub const CreateSessionOutput = struct {
    /// The timestamp for when the session was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the created session.
    session_arn: []const u8,

    /// The unique identifier for the session.
    session_id: []const u8,

    /// The current status of the session.
    session_status: SessionStatus,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .session_arn = "sessionArn",
        .session_id = "sessionId",
        .session_status = "sessionStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSessionInput, options: CallOptions) !CreateSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent-runtime", "Bedrock Agent Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/sessions/";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.encryption_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"encryptionKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.session_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionMetadata\":");
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
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSessionOutput {
    const result: CreateSessionOutput = try aws.json.parseJsonObject(
        CreateSessionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
