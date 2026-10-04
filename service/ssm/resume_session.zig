const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ResumeSessionInput = struct {
    /// The ID of the disconnected session to resume.
    session_id: []const u8,

    pub const json_field_names = .{
        .session_id = "SessionId",
    };
};

pub const ResumeSessionOutput = struct {
    /// The ID of the session.
    session_id: ?[]const u8 = null,

    /// A URL back to SSM Agent on the managed node that the Session Manager client
    /// uses to send commands and
    /// receive output from the managed node. Format:
    /// `wss://ssmmessages.**region**.amazonaws.com/v1/data-channel/**session-id**?stream=(input|output)`.
    ///
    /// **region** represents the Region identifier for an
    /// Amazon Web Services Region supported by Amazon Web Services Systems Manager,
    /// such as `us-east-2` for the US East (Ohio) Region.
    /// For a list of supported **region** values, see the **Region** column in
    /// [Systems Manager service
    /// endpoints](https://docs.aws.amazon.com/general/latest/gr/ssm.html#ssm_region) in the
    /// *Amazon Web Services General Reference*.
    ///
    /// **session-id** represents the ID of a Session Manager session, such as
    /// `1a2b3c4dEXAMPLE`.
    stream_url: ?[]const u8 = null,

    /// An encrypted token value containing session and caller information. Used to
    /// authenticate the
    /// connection to the managed node.
    token_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .session_id = "SessionId",
        .stream_url = "StreamUrl",
        .token_value = "TokenValue",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ResumeSessionInput, options: CallOptions) !ResumeSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ResumeSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.ResumeSession");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ResumeSessionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ResumeSessionOutput, body, allocator);
}
