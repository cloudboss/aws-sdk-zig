const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Entity = @import("entity.zig").Entity;
const InputLogEvent = @import("input_log_event.zig").InputLogEvent;
const RejectedEntityInfo = @import("rejected_entity_info.zig").RejectedEntityInfo;
const RejectedLogEventsInfo = @import("rejected_log_events_info.zig").RejectedLogEventsInfo;

pub const PutLogEventsInput = struct {
    /// The entity associated with the log events.
    entity: ?Entity = null,

    /// The log events.
    log_events: []const InputLogEvent,

    /// The name of the log group.
    log_group_name: []const u8,

    /// The name of the log stream.
    log_stream_name: []const u8,

    /// The sequence token obtained from the response of the previous `PutLogEvents`
    /// call.
    ///
    /// The `sequenceToken` parameter is now ignored in `PutLogEvents`
    /// actions. `PutLogEvents` actions are now accepted and never return
    /// `InvalidSequenceTokenException` or `DataAlreadyAcceptedException`
    /// even if the sequence token is not valid.
    sequence_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .entity = "entity",
        .log_events = "logEvents",
        .log_group_name = "logGroupName",
        .log_stream_name = "logStreamName",
        .sequence_token = "sequenceToken",
    };
};

pub const PutLogEventsOutput = struct {
    /// The next sequence token.
    ///
    /// This field has been deprecated.
    ///
    /// The sequence token is now ignored in `PutLogEvents` actions.
    /// `PutLogEvents` actions are always accepted even if the sequence token is not
    /// valid. You can use parallel `PutLogEvents` actions on the same log stream
    /// and you
    /// do not need to wait for the response of a previous `PutLogEvents` action to
    /// obtain the `nextSequenceToken` value.
    next_sequence_token: ?[]const u8 = null,

    /// Information about why the entity is rejected when calling `PutLogEvents`.
    /// Only
    /// returned when the entity is rejected.
    ///
    /// When the entity is rejected, the events may still be accepted.
    rejected_entity_info: ?RejectedEntityInfo = null,

    /// The rejected events.
    rejected_log_events_info: ?RejectedLogEventsInfo = null,

    pub const json_field_names = .{
        .next_sequence_token = "nextSequenceToken",
        .rejected_entity_info = "rejectedEntityInfo",
        .rejected_log_events_info = "rejectedLogEventsInfo",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutLogEventsInput, options: CallOptions) !PutLogEventsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutLogEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.PutLogEvents");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutLogEventsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutLogEventsOutput, body, allocator);
}
