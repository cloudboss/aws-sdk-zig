const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Player = @import("player.zig").Player;
const MatchmakingTicket = @import("matchmaking_ticket.zig").MatchmakingTicket;

pub const StartMatchmakingInput = struct {
    /// Name of the matchmaking configuration to use for this request. Matchmaking
    /// configurations must exist in the same Region as this request. You can use
    /// either the
    /// configuration name or ARN value.
    configuration_name: []const u8,

    /// Information on each player to be matched. This information must include a
    /// player ID,
    /// and may contain player attributes and latency data to be used in the
    /// matchmaking
    /// process. After a successful match, `Player` objects contain the name of the
    /// team the player is assigned to.
    ///
    /// You can include up to 10 `Players` in a `StartMatchmaking`
    /// request.
    players: []const Player,

    /// A unique identifier for a matchmaking ticket. If no ticket ID is specified
    /// here, Amazon GameLift Servers will generate one in the form of a
    /// UUID. Use this identifier to track the matchmaking ticket status and
    /// retrieve match
    /// results.
    ticket_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_name = "ConfigurationName",
        .players = "Players",
        .ticket_id = "TicketId",
    };
};

pub const StartMatchmakingOutput = struct {
    /// Ticket representing the matchmaking request. This object include the
    /// information
    /// included in the request, ticket status, and match results as generated
    /// during the
    /// matchmaking process.
    matchmaking_ticket: ?MatchmakingTicket = null,

    pub const json_field_names = .{
        .matchmaking_ticket = "MatchmakingTicket",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMatchmakingInput, options: CallOptions) !StartMatchmakingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartMatchmakingInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.StartMatchmaking");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartMatchmakingOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartMatchmakingOutput, body, allocator);
}
