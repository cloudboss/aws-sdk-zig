const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GameServerGroupAction = @import("game_server_group_action.zig").GameServerGroupAction;
const GameServerGroup = @import("game_server_group.zig").GameServerGroup;

pub const SuspendGameServerGroupInput = struct {
    /// A unique identifier for the game server group. Use either the name or ARN
    /// value.
    game_server_group_name: []const u8,

    /// The activity to suspend for this game server group.
    suspend_actions: []const GameServerGroupAction,

    pub const json_field_names = .{
        .game_server_group_name = "GameServerGroupName",
        .suspend_actions = "SuspendActions",
    };
};

pub const SuspendGameServerGroupOutput = struct {
    /// An object that describes the game server group resource, with the
    /// `SuspendedActions` property updated to reflect the suspended
    /// activity.
    game_server_group: ?GameServerGroup = null,

    pub const json_field_names = .{
        .game_server_group = "GameServerGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SuspendGameServerGroupInput, options: CallOptions) !SuspendGameServerGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SuspendGameServerGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.SuspendGameServerGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SuspendGameServerGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SuspendGameServerGroupOutput, body, allocator);
}
