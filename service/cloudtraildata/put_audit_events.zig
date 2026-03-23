const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudtraildataservice");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: PutAuditEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail-data", "CloudTrail Data", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/PutAuditEvents";

    var query_buf: std.ArrayList(u8) = .{};
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

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"auditEvents\":");
    try aws.json.writeValue(@TypeOf(input.audit_events), input.audit_events, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAuditEventsOutput {
    var result: PutAuditEventsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutAuditEventsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ChannelInsufficientPermission")) {
        return .{ .arena = arena, .kind = .{ .channel_insufficient_permission = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ChannelNotFound")) {
        return .{ .arena = arena, .kind = .{ .channel_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ChannelUnsupportedSchema")) {
        return .{ .arena = arena, .kind = .{ .channel_unsupported_schema = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicatedAuditEventId")) {
        return .{ .arena = arena, .kind = .{ .duplicated_audit_event_id = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidChannelARN")) {
        return .{ .arena = arena, .kind = .{ .invalid_channel_arn = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
