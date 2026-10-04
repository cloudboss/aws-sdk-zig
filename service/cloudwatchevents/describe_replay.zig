const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReplayDestination = @import("replay_destination.zig").ReplayDestination;
const ReplayState = @import("replay_state.zig").ReplayState;

pub const DescribeReplayInput = struct {
    /// The name of the replay to retrieve.
    replay_name: []const u8,

    pub const json_field_names = .{
        .replay_name = "ReplayName",
    };
};

pub const DescribeReplayOutput = struct {
    /// The description of the replay.
    description: ?[]const u8 = null,

    /// A `ReplayDestination` object that contains details about the replay.
    destination: ?ReplayDestination = null,

    /// The time stamp for the last event that was replayed from the archive.
    event_end_time: ?i64 = null,

    /// The time that the event was last replayed.
    event_last_replayed_time: ?i64 = null,

    /// The ARN of the archive events were replayed from.
    event_source_arn: ?[]const u8 = null,

    /// The time stamp of the first event that was last replayed from the archive.
    event_start_time: ?i64 = null,

    /// The ARN of the replay.
    replay_arn: ?[]const u8 = null,

    /// A time stamp for the time that the replay stopped.
    replay_end_time: ?i64 = null,

    /// The name of the replay.
    replay_name: ?[]const u8 = null,

    /// A time stamp for the time that the replay started.
    replay_start_time: ?i64 = null,

    /// The current state of the replay.
    state: ?ReplayState = null,

    /// The reason that the replay is in the current state.
    state_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .destination = "Destination",
        .event_end_time = "EventEndTime",
        .event_last_replayed_time = "EventLastReplayedTime",
        .event_source_arn = "EventSourceArn",
        .event_start_time = "EventStartTime",
        .replay_arn = "ReplayArn",
        .replay_end_time = "ReplayEndTime",
        .replay_name = "ReplayName",
        .replay_start_time = "ReplayStartTime",
        .state = "State",
        .state_reason = "StateReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeReplayInput, options: CallOptions) !DescribeReplayOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "events", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeReplayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("events", "CloudWatch Events", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.DescribeReplay");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeReplayOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeReplayOutput, body, allocator);
}
