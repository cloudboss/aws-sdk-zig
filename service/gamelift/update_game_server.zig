const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GameServerHealthCheck = @import("game_server_health_check.zig").GameServerHealthCheck;
const GameServerUtilizationStatus = @import("game_server_utilization_status.zig").GameServerUtilizationStatus;
const GameServer = @import("game_server.zig").GameServer;

pub const UpdateGameServerInput = struct {
    /// A set of custom game server properties, formatted as a single string value.
    /// This data
    /// is passed to a game client or service when it requests information on game
    /// servers.
    game_server_data: ?[]const u8 = null,

    /// A unique identifier for the game server group where the game server is
    /// running.
    game_server_group_name: []const u8,

    /// A custom string that uniquely identifies the game server to update.
    game_server_id: []const u8,

    /// Indicates health status of the game server. A request that includes this
    /// parameter
    /// updates the game server's *LastHealthCheckTime* timestamp.
    health_check: ?GameServerHealthCheck = null,

    /// Indicates if the game server is available or is currently hosting gameplay.
    /// You can
    /// update a game server status from `AVAILABLE` to `UTILIZED`, but
    /// you can't change a the status from `UTILIZED` to
    /// `AVAILABLE`.
    utilization_status: ?GameServerUtilizationStatus = null,

    pub const json_field_names = .{
        .game_server_data = "GameServerData",
        .game_server_group_name = "GameServerGroupName",
        .game_server_id = "GameServerId",
        .health_check = "HealthCheck",
        .utilization_status = "UtilizationStatus",
    };
};

pub const UpdateGameServerOutput = struct {
    /// Object that describes the newly updated game server.
    game_server: ?GameServer = null,

    pub const json_field_names = .{
        .game_server = "GameServer",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGameServerInput, options: CallOptions) !UpdateGameServerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGameServerInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.UpdateGameServer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGameServerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateGameServerOutput, body, allocator);
}
