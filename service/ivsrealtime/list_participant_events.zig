const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Event = @import("event.zig").Event;

pub const ListParticipantEventsInput = struct {
    /// Maximum number of results to return. Default: 50.
    max_results: ?i32 = null,

    /// The first participant event to retrieve. This is used for pagination; see
    /// the
    /// `nextToken` response field.
    next_token: ?[]const u8 = null,

    /// Unique identifier for this participant. This is assigned by IVS and returned
    /// by CreateParticipantToken.
    participant_id: []const u8,

    /// ID of a session within the stage.
    session_id: []const u8,

    /// Stage ARN.
    stage_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .participant_id = "participantId",
        .session_id = "sessionId",
        .stage_arn = "stageArn",
    };
};

pub const ListParticipantEventsOutput = struct {
    /// List of the matching events.
    events: ?[]const Event = null,

    /// If there are more events than `maxResults`, use `nextToken` in the
    /// request to get the next set.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .events = "events",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListParticipantEventsInput, options: CallOptions) !ListParticipantEventsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListParticipantEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivsrealtime", "IVS RealTime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListParticipantEvents";

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
    try body_buf.appendSlice(allocator, "\"sessionId\":");
    try aws.json.writeValue(@TypeOf(input.session_id), input.session_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"stageArn\":");
    try aws.json.writeValue(@TypeOf(input.stage_arn), input.stage_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListParticipantEventsOutput {
    var result: ListParticipantEventsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListParticipantEventsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
