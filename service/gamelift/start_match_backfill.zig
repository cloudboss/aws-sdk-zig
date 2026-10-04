const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Player = @import("player.zig").Player;
const MatchmakingTicket = @import("matchmaking_ticket.zig").MatchmakingTicket;

pub const StartMatchBackfillInput = struct {
    /// Name of the matchmaker to use for this request. You can use either the
    /// configuration
    /// name or ARN value. The ARN of the matchmaker that was used with the original
    /// game
    /// session is listed in the `GameSession` object, `MatchmakerData`
    /// property.
    configuration_name: []const u8,

    /// An identifier for the game session that is unique across all regions. The
    /// value is always a full ARN in the following format:
    /// `arn:aws:gamelift:::gamesession//`. When using FlexMatch as a standalone
    /// matchmaking
    /// solution, this parameter is not needed.
    game_session_arn: ?[]const u8 = null,

    /// Match information on all players that are currently assigned to the game
    /// session. This
    /// information is used by the matchmaker to find new players and add them to
    /// the existing
    /// game.
    ///
    /// You can include up to 199 `Players` in a `StartMatchBackfill`
    /// request.
    ///
    /// * PlayerID, PlayerAttributes, Team -- This information is maintained in the
    /// `GameSession` object, `MatchmakerData` property, for
    /// all players who are currently assigned to the game session. The matchmaker
    /// data
    /// is in JSON syntax, formatted as a string. For more details, see [
    /// Match
    /// Data](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-server.html#match-server-data).
    ///
    /// The backfill request must specify the team membership for every player. Do
    /// not
    /// specify team if you are not using backfill.
    ///
    /// * LatencyInMs -- If the matchmaker uses player latency, include a latency
    ///   value,
    /// in milliseconds, for the Region that the game session is currently in. Do
    /// not
    /// include latency values for any other Region.
    players: []const Player,

    /// A unique identifier for a matchmaking ticket. If no ticket ID is specified
    /// here, Amazon GameLift Servers will generate one in the form of a
    /// UUID. Use this identifier to track the match backfill ticket status and
    /// retrieve match
    /// results.
    ticket_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_name = "ConfigurationName",
        .game_session_arn = "GameSessionArn",
        .players = "Players",
        .ticket_id = "TicketId",
    };
};

pub const StartMatchBackfillOutput = struct {
    /// Ticket representing the backfill matchmaking request. This object includes
    /// the
    /// information in the request, ticket status, and match results as generated
    /// during the
    /// matchmaking process.
    matchmaking_ticket: ?MatchmakingTicket = null,

    pub const json_field_names = .{
        .matchmaking_ticket = "MatchmakingTicket",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMatchBackfillInput, options: CallOptions) !StartMatchBackfillOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartMatchBackfillInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.StartMatchBackfill");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartMatchBackfillOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartMatchBackfillOutput, body, allocator);
}
