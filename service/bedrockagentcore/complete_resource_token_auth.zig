const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserIdentifier = @import("user_identifier.zig").UserIdentifier;

pub const CompleteResourceTokenAuthInput = struct {
    /// Unique identifier for the user's authentication session for retrieving
    /// OAuth2 tokens. This ID tracks the authorization flow state across multiple
    /// requests and responses during the OAuth2 authentication process.
    session_uri: []const u8,

    /// The OAuth2.0 token or user ID that was used to generate the workload access
    /// token used for initiating the user authorization flow to retrieve OAuth2.0
    /// tokens.
    user_identifier: UserIdentifier,

    pub const json_field_names = .{
        .session_uri = "sessionUri",
        .user_identifier = "userIdentifier",
    };
};

pub const CompleteResourceTokenAuthOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CompleteResourceTokenAuthInput, options: CallOptions) !CompleteResourceTokenAuthOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CompleteResourceTokenAuthInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/identities/CompleteResourceTokenAuth";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sessionUri\":");
    try aws.json.writeValue(@TypeOf(input.session_uri), input.session_uri, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"userIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.user_identifier), input.user_identifier, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CompleteResourceTokenAuthOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: CompleteResourceTokenAuthOutput = .{};

    return result;
}
