const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GameSessionPlacement = @import("game_session_placement.zig").GameSessionPlacement;

pub const StopGameSessionPlacementInput = struct {
    /// A unique identifier for a game session placement to stop.
    placement_id: []const u8,

    pub const json_field_names = .{
        .placement_id = "PlacementId",
    };
};

pub const StopGameSessionPlacementOutput = struct {
    /// Object that describes the canceled game session placement, with `CANCELLED`
    /// status and an end time stamp.
    game_session_placement: ?GameSessionPlacement = null,

    pub const json_field_names = .{
        .game_session_placement = "GameSessionPlacement",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopGameSessionPlacementInput, options: CallOptions) !StopGameSessionPlacementOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StopGameSessionPlacementInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.StopGameSessionPlacement");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopGameSessionPlacementOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StopGameSessionPlacementOutput, body, allocator);
}
