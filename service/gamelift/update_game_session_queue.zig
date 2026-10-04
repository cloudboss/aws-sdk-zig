const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GameSessionQueueDestination = @import("game_session_queue_destination.zig").GameSessionQueueDestination;
const FilterConfiguration = @import("filter_configuration.zig").FilterConfiguration;
const PlayerLatencyPolicy = @import("player_latency_policy.zig").PlayerLatencyPolicy;
const PriorityConfiguration = @import("priority_configuration.zig").PriorityConfiguration;
const GameSessionQueue = @import("game_session_queue.zig").GameSessionQueue;

pub const UpdateGameSessionQueueInput = struct {
    /// Information to be added to all events that are related to this game session
    /// queue.
    custom_event_data: ?[]const u8 = null,

    /// A list of fleets and/or fleet aliases that can be used to fulfill game
    /// session placement requests in the queue.
    /// Destinations are identified by either a fleet ARN or a fleet alias ARN, and
    /// are listed in order of placement preference. When updating this list,
    /// provide a complete list of destinations.
    destinations: ?[]const GameSessionQueueDestination = null,

    /// A list of locations where a queue is allowed to place new game sessions.
    /// Locations
    /// are specified in the form of Amazon Web Services Region codes, such as
    /// `us-west-2`. If this parameter is
    /// not set, game sessions can be placed in any queue location. To remove an
    /// existing filter configuration, pass in an empty set.
    filter_configuration: ?FilterConfiguration = null,

    /// A descriptive label that is associated with game session queue. Queue names
    /// must be unique within each Region. You can use either the queue ID or ARN
    /// value.
    name: []const u8,

    /// An SNS topic ARN that is set up to receive game session placement
    /// notifications. See
    /// [ Setting up
    /// notifications for game session
    /// placement](https://docs.aws.amazon.com/gamelift/latest/developerguide/queue-notification.html).
    notification_target: ?[]const u8 = null,

    /// A set of policies that enforce a sliding cap on player latency when
    /// processing game sessions placement requests.
    /// Use multiple policies to gradually relax the cap over time if Amazon
    /// GameLift Servers can't make a placement.
    /// Policies are evaluated in order starting with the lowest maximum latency
    /// value. When updating policies, provide a complete collection of policies.
    player_latency_policies: ?[]const PlayerLatencyPolicy = null,

    /// Custom settings to use when prioritizing destinations and locations for game
    /// session placements. This
    /// configuration replaces the FleetIQ default prioritization process. Priority
    /// types that are not explicitly
    /// named will be automatically applied at the end of the prioritization
    /// process. To remove an existing priority configuration, pass in an empty set.
    priority_configuration: ?PriorityConfiguration = null,

    /// The maximum time, in seconds, that a new game session placement request
    /// remains in the queue. When a request exceeds this time, the game session
    /// placement changes to a `TIMED_OUT` status.
    ///
    /// The minimum value is 10 and the maximum value is 600.
    timeout_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .custom_event_data = "CustomEventData",
        .destinations = "Destinations",
        .filter_configuration = "FilterConfiguration",
        .name = "Name",
        .notification_target = "NotificationTarget",
        .player_latency_policies = "PlayerLatencyPolicies",
        .priority_configuration = "PriorityConfiguration",
        .timeout_in_seconds = "TimeoutInSeconds",
    };
};

pub const UpdateGameSessionQueueOutput = struct {
    /// An object that describes the newly updated game session queue.
    game_session_queue: ?GameSessionQueue = null,

    pub const json_field_names = .{
        .game_session_queue = "GameSessionQueue",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGameSessionQueueInput, options: CallOptions) !UpdateGameSessionQueueOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGameSessionQueueInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.UpdateGameSessionQueue");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGameSessionQueueOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateGameSessionQueueOutput, body, allocator);
}
