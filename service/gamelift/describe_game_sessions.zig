const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GameSession = @import("game_session.zig").GameSession;

pub const DescribeGameSessionsInput = struct {
    /// A unique identifier for the alias associated with the fleet to retrieve game
    /// sessions for. You can use either the
    /// alias ID or ARN value.
    alias_id: ?[]const u8 = null,

    /// A unique identifier for the fleet to retrieve game sessions for. You can use
    /// either the fleet ID or ARN value.
    fleet_id: ?[]const u8 = null,

    /// An identifier for the game session that is unique across all regions to
    /// retrieve. The value is always a full ARN in the following format:
    /// `arn:aws:gamelift:::gamesession//`.
    game_session_id: ?[]const u8 = null,

    /// The maximum number of results to return. Use this parameter with `NextToken`
    /// to get results as a set of sequential pages.
    limit: ?i32 = null,

    /// A fleet location to get game sessions for. You can specify a fleet's home
    /// Region or a
    /// remote location. Use the Amazon Web Services Region code format, such as
    /// `us-west-2`.
    location: ?[]const u8 = null,

    /// A token that indicates the start of the next sequential page of results. Use
    /// the token that is returned with a previous call to this operation. To start
    /// at the beginning of the result set, do not specify a value.
    next_token: ?[]const u8 = null,

    /// Game session status to filter results on. You can filter on the following
    /// states:
    /// `ACTIVE`, `TERMINATED`, `ACTIVATING`, and
    /// `TERMINATING`. The last two are transitory and used for only very brief
    /// periods of time.
    status_filter: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias_id = "AliasId",
        .fleet_id = "FleetId",
        .game_session_id = "GameSessionId",
        .limit = "Limit",
        .location = "Location",
        .next_token = "NextToken",
        .status_filter = "StatusFilter",
    };
};

pub const DescribeGameSessionsOutput = struct {
    /// A collection of properties for each game session that matches the request.
    game_sessions: ?[]const GameSession = null,

    /// A token that indicates where to resume retrieving results on the next call
    /// to this operation. If no token is returned, these results represent the end
    /// of the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .game_sessions = "GameSessions",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeGameSessionsInput, options: CallOptions) !DescribeGameSessionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeGameSessionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.DescribeGameSessions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeGameSessionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeGameSessionsOutput, body, allocator);
}
