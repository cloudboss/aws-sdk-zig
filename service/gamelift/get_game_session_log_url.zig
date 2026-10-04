const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetGameSessionLogUrlInput = struct {
    /// An identifier for the game session that is unique across all regions to get
    /// logs for. The value is always a full ARN in the following format:
    /// `arn:aws:gamelift:::gamesession//`.
    game_session_id: []const u8,

    pub const json_field_names = .{
        .game_session_id = "GameSessionId",
    };
};

pub const GetGameSessionLogUrlOutput = struct {
    /// Location of the requested game session logs, available for download. This
    /// URL is valid
    /// for 15 minutes, after which S3 will reject any download request using this
    /// URL. You can
    /// request a new URL any time within the 14-day period that the logs are
    /// retained.
    pre_signed_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .pre_signed_url = "PreSignedUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGameSessionLogUrlInput, options: CallOptions) !GetGameSessionLogUrlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gamelift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGameSessionLogUrlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.GetGameSessionLogUrl");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGameSessionLogUrlOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetGameSessionLogUrlOutput, body, allocator);
}
