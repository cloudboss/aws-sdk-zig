const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EventReference = @import("event_reference.zig").EventReference;

pub const CreateTimelineEventInput = struct {
    /// A token that ensures that a client calls the action only once with the
    /// specified
    /// details.
    client_token: ?[]const u8 = null,

    /// A short description of the event.
    event_data: []const u8,

    /// Adds one or more references to the `TimelineEvent`. A reference is an Amazon
    /// Web Services resource involved or associated with the incident. To specify a
    /// reference, enter
    /// its Amazon Resource Name (ARN). You can also specify a related item
    /// associated with a
    /// resource. For example, to specify an Amazon DynamoDB (DynamoDB) table as a
    /// resource, use the table's ARN. You can also specify an Amazon CloudWatch
    /// metric associated
    /// with the DynamoDB table as a related item.
    event_references: ?[]const EventReference = null,

    /// The timestamp for when the event occurred.
    event_time: i64,

    /// The type of event. You can create timeline events of type `Custom Event` and
    /// `Note`.
    ///
    /// To make a Note-type event appear on the *Incident notes* panel in the
    /// console, specify `eventType` as `Note`and enter the Amazon Resource Name
    /// (ARN) of the incident as the value for `eventReference`.
    event_type: []const u8,

    /// The Amazon Resource Name (ARN) of the incident record that the action adds
    /// the incident
    /// to.
    incident_record_arn: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .event_data = "eventData",
        .event_references = "eventReferences",
        .event_time = "eventTime",
        .event_type = "eventType",
        .incident_record_arn = "incidentRecordArn",
    };
};

pub const CreateTimelineEventOutput = struct {
    /// The ID of the event for easy reference later.
    event_id: []const u8,

    /// The ARN of the incident record that you added the event to.
    incident_record_arn: []const u8,

    pub const json_field_names = .{
        .event_id = "eventId",
        .incident_record_arn = "incidentRecordArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTimelineEventInput, options: Options) !CreateTimelineEventOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ssmincidents");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateTimelineEventInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssmincidents", "SSM Incidents", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/createTimelineEvent";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"eventData\":");
    try aws.json.writeValue(@TypeOf(input.event_data), input.event_data, alloc, &body_buf);
    has_prev = true;
    if (input.event_references) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"eventReferences\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"eventTime\":");
    try aws.json.writeValue(@TypeOf(input.event_time), input.event_time, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"eventType\":");
    try aws.json.writeValue(@TypeOf(input.event_type), input.event_type, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"incidentRecordArn\":");
    try aws.json.writeValue(@TypeOf(input.incident_record_arn), input.incident_record_arn, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateTimelineEventOutput {
    var result: CreateTimelineEventOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateTimelineEventOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
