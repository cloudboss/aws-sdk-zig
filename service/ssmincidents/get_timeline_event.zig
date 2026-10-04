const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TimelineEvent = @import("timeline_event.zig").TimelineEvent;

pub const GetTimelineEventInput = struct {
    /// The ID of the event. You can get an event's ID when you create it, or by
    /// using
    /// `ListTimelineEvents`.
    event_id: []const u8,

    /// The Amazon Resource Name (ARN) of the incident that includes the timeline
    /// event.
    incident_record_arn: []const u8,

    pub const json_field_names = .{
        .event_id = "eventId",
        .incident_record_arn = "incidentRecordArn",
    };
};

pub const GetTimelineEventOutput = struct {
    /// Details about the timeline event.
    event: ?TimelineEvent = null,

    pub const json_field_names = .{
        .event = "event",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTimelineEventInput, options: CallOptions) !GetTimelineEventOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-incidents", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTimelineEventInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-incidents", "SSM Incidents", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/getTimelineEvent";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "eventId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.event_id);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "incidentRecordArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.incident_record_arn);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTimelineEventOutput {
    const result: GetTimelineEventOutput = try aws.json.parseJsonObject(
        GetTimelineEventOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
