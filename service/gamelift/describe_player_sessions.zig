const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PlayerSession = @import("player_session.zig").PlayerSession;

pub const DescribePlayerSessionsInput = struct {
    /// An identifier for the game session that is unique across all regions to
    /// retrieve player sessions for. The value is always a full ARN in the
    /// following format: For Home Region game session -
    /// `arn:aws:gamelift:::gamesession//`. For Remote Location game session -
    /// `arn:aws:gamelift:::gamesession///`.
    game_session_id: ?[]const u8 = null,

    /// The maximum number of results to return. Use this parameter with `NextToken`
    /// to get results as a set of sequential pages. If a player session ID is
    /// specified, this parameter is ignored.
    limit: ?i32 = null,

    /// A token that indicates the start of the next sequential page of results. Use
    /// the token that is returned with a previous call to this operation. To start
    /// at the beginning of the result set, do not specify a value. If a player
    /// session ID is specified, this parameter is ignored.
    next_token: ?[]const u8 = null,

    /// A unique identifier for a player to retrieve player sessions for.
    player_id: ?[]const u8 = null,

    /// A unique identifier for a player session to retrieve.
    player_session_id: ?[]const u8 = null,

    /// Player session status to filter results on. Note that when a PlayerSessionId
    /// or
    /// PlayerId is provided in a DescribePlayerSessions request, then the
    /// PlayerSessionStatusFilter has no effect on the response.
    ///
    /// Possible player session statuses include the following:
    ///
    /// * **RESERVED** -- The player session request has been
    /// received, but the player has not yet connected to the server process and/or
    /// been
    /// validated.
    ///
    /// * **ACTIVE** -- The player has been validated by the
    /// server process and is currently connected.
    ///
    /// * **COMPLETED** -- The player connection has been
    /// dropped.
    ///
    /// * **TIMEDOUT** -- A player session request was
    /// received, but the player did not connect and/or was not validated within the
    /// timeout limit (60 seconds).
    player_session_status_filter: ?[]const u8 = null,

    pub const json_field_names = .{
        .game_session_id = "GameSessionId",
        .limit = "Limit",
        .next_token = "NextToken",
        .player_id = "PlayerId",
        .player_session_id = "PlayerSessionId",
        .player_session_status_filter = "PlayerSessionStatusFilter",
    };
};

pub const DescribePlayerSessionsOutput = struct {
    /// A token that indicates where to resume retrieving results on the next call
    /// to this operation. If no token is returned, these results represent the end
    /// of the list.
    next_token: ?[]const u8 = null,

    /// A collection of objects containing properties for each player session that
    /// matches the
    /// request.
    player_sessions: ?[]const PlayerSession = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .player_sessions = "PlayerSessions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePlayerSessionsInput, options: CallOptions) !DescribePlayerSessionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePlayerSessionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.DescribePlayerSessions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePlayerSessionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribePlayerSessionsOutput, body, allocator);
}
