const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ParticipantReplica = @import("participant_replica.zig").ParticipantReplica;

pub const ListParticipantReplicasInput = struct {
    /// Maximum number of results to return. Default: 50.
    max_results: ?i32 = null,

    /// The first participant to retrieve. This is used for pagination; see the
    /// `nextToken` response field.
    next_token: ?[]const u8 = null,

    /// Participant ID of the publisher that has been replicated. This is assigned
    /// by IVS and returned by
    /// CreateParticipantToken
    /// or the `jti` (JWT ID) used to [create a self signed
    /// token](https://docs.aws.amazon.com/ivs/latest/RealTimeUserGuide/getting-started-distribute-tokens.html#getting-started-distribute-tokens-self-signed).
    participant_id: []const u8,

    /// ARN of the stage where the participant is publishing.
    source_stage_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .participant_id = "participantId",
        .source_stage_arn = "sourceStageArn",
    };
};

pub const ListParticipantReplicasOutput = struct {
    /// If there are more participants than `maxResults`, use `nextToken` in the
    /// request to get the next set.
    next_token: ?[]const u8 = null,

    /// List of all participant replicas.
    replicas: ?[]const ParticipantReplica = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .replicas = "replicas",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListParticipantReplicasInput, options: CallOptions) !ListParticipantReplicasOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ivs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListParticipantReplicasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivsrealtime", "IVS RealTime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListParticipantReplicas";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"participantId\":");
    try aws.json.writeValue(@TypeOf(input.participant_id), input.participant_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceStageArn\":");
    try aws.json.writeValue(@TypeOf(input.source_stage_arn), input.source_stage_arn, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListParticipantReplicasOutput {
    var result: ListParticipantReplicasOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListParticipantReplicasOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
