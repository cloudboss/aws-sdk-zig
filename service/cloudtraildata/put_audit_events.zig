const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuditEvent = @import("audit_event.zig").AuditEvent;
const ResultErrorEntry = @import("result_error_entry.zig").ResultErrorEntry;
const AuditEventResultEntry = @import("audit_event_result_entry.zig").AuditEventResultEntry;

pub const PutAuditEventsInput = struct {
    /// The JSON payload of events that you want to ingest. You can also point to
    /// the JSON event
    /// payload in a file.
    audit_events: []const AuditEvent,

    /// The ARN or ID (the ARN suffix) of a channel.
    channel_arn: []const u8,

    /// A unique identifier that is conditionally required when the channel's
    /// resource policy includes an external
    /// ID. This value can be any string,
    /// such as a passphrase or account number.
    external_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .audit_events = "auditEvents",
        .channel_arn = "channelArn",
        .external_id = "externalId",
    };
};

pub const PutAuditEventsOutput = struct {
    /// Lists events in the provided event payload that could not be
    /// ingested into CloudTrail, and includes the error code and error message
    /// returned for events that could not be ingested.
    failed: ?[]const ResultErrorEntry = null,

    /// Lists events in the provided event payload that were successfully ingested
    /// into CloudTrail.
    successful: ?[]const AuditEventResultEntry = null,

    pub const json_field_names = .{
        .failed = "failed",
        .successful = "successful",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAuditEventsInput, options: CallOptions) !PutAuditEventsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtraildataservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAuditEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail-data", "CloudTrail Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/PutAuditEvents";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "channelArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.channel_arn);
    query_has_prev = true;
    if (input.external_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "externalId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"auditEvents\":");
    try aws.json.writeValue(@TypeOf(input.audit_events), input.audit_events, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAuditEventsOutput {
    const result: PutAuditEventsOutput = try aws.json.parseJsonObject(
        PutAuditEventsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
