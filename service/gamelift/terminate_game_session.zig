const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TerminationMode = @import("termination_mode.zig").TerminationMode;
const GameSession = @import("game_session.zig").GameSession;

pub const TerminateGameSessionInput = struct {
    /// An identifier for the game session that is unique across all regions to be
    /// terminated. The value is always a full ARN in the following format: For Home
    /// Region game session - `arn:aws:gamelift:::gamesession//`. For Remote
    /// Location game session - `arn:aws:gamelift:::gamesession///`.
    game_session_id: []const u8,

    /// The method to use to terminate the game session. Available methods include:
    ///
    /// * `TRIGGER_ON_PROCESS_TERMINATE` – Prompts the Amazon GameLift Servers
    ///   service to
    /// send an `OnProcessTerminate()` callback to the server process and
    /// initiate the normal game session shutdown sequence. The
    /// `OnProcessTerminate` method, which is implemented in the game
    /// server code, must include a call to the server SDK action
    /// `ProcessEnding()`, which is how the server process signals to
    /// Amazon GameLift Servers that a game session is ending. If the server process
    /// doesn't call
    /// `ProcessEnding()`, the game session termination won't conclude
    /// successfully.
    ///
    /// * `FORCE_TERMINATE` – Prompts the Amazon GameLift Servers service to stop
    ///   the server
    /// process immediately. Amazon GameLift Servers takes action (depending on the
    /// type of fleet) to
    /// shut down the server process without the normal game session shutdown
    /// sequence.
    ///
    /// This method is not available for game sessions that are running on
    /// Anywhere fleets unless the fleet is deployed with the Amazon GameLift
    /// Servers Agent. In this
    /// scenario, a force terminate request results in an invalid or bad request
    /// exception.
    termination_mode: TerminationMode,

    pub const json_field_names = .{
        .game_session_id = "GameSessionId",
        .termination_mode = "TerminationMode",
    };
};

pub const TerminateGameSessionOutput = struct {
    game_session: ?GameSession = null,

    pub const json_field_names = .{
        .game_session = "GameSession",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TerminateGameSessionInput, options: CallOptions) !TerminateGameSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: TerminateGameSessionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.TerminateGameSession");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TerminateGameSessionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(TerminateGameSessionOutput, body, allocator);
}
