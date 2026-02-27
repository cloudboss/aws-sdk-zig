const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EventTriggerCondition = @import("event_trigger_condition.zig").EventTriggerCondition;
const EventTriggerLimits = @import("event_trigger_limits.zig").EventTriggerLimits;

pub const UpdateEventTriggerInput = struct {
    /// The description of the event trigger.
    description: ?[]const u8 = null,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// A list of conditions that determine when an event should trigger the
    /// destination.
    event_trigger_conditions: ?[]const EventTriggerCondition = null,

    /// Defines limits controlling whether an event triggers the destination, based
    /// on ingestion
    /// latency and the number of invocations per profile over specific time
    /// periods.
    event_trigger_limits: ?EventTriggerLimits = null,

    /// The unique name of the event trigger.
    event_trigger_name: []const u8,

    /// The unique name of the object type.
    object_type_name: ?[]const u8 = null,

    /// The destination is triggered only for profiles that meet the criteria of a
    /// segment
    /// definition.
    segment_filter: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .domain_name = "DomainName",
        .event_trigger_conditions = "EventTriggerConditions",
        .event_trigger_limits = "EventTriggerLimits",
        .event_trigger_name = "EventTriggerName",
        .object_type_name = "ObjectTypeName",
        .segment_filter = "SegmentFilter",
    };
};

pub const UpdateEventTriggerOutput = struct {
    /// The timestamp of when the event trigger was created.
    created_at: ?i64 = null,

    /// The description of the event trigger.
    description: ?[]const u8 = null,

    /// A list of conditions that determine when an event should trigger the
    /// destination.
    event_trigger_conditions: ?[]const EventTriggerCondition = null,

    /// Defines limits controlling whether an event triggers the destination, based
    /// on ingestion
    /// latency and the number of invocations per profile over specific time
    /// periods.
    event_trigger_limits: ?EventTriggerLimits = null,

    /// The unique name of the event trigger.
    event_trigger_name: ?[]const u8 = null,

    /// The timestamp of when the event trigger was most recently updated.
    last_updated_at: ?i64 = null,

    /// The unique name of the object type.
    object_type_name: ?[]const u8 = null,

    /// The destination is triggered only for profiles that meet the criteria of a
    /// segment
    /// definition.
    segment_filter: ?[]const u8 = null,

    /// An array of key-value pairs to apply to this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .event_trigger_conditions = "EventTriggerConditions",
        .event_trigger_limits = "EventTriggerLimits",
        .event_trigger_name = "EventTriggerName",
        .last_updated_at = "LastUpdatedAt",
        .object_type_name = "ObjectTypeName",
        .segment_filter = "SegmentFilter",
        .tags = "Tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEventTriggerInput, options: Options) !UpdateEventTriggerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "customerprofiles");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateEventTriggerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("customerprofiles", "Customer Profiles", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/domains/");
    try path_buf.appendSlice(alloc, input.domain_name);
    try path_buf.appendSlice(alloc, "/event-triggers/");
    try path_buf.appendSlice(alloc, input.event_trigger_name);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.event_trigger_conditions) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"EventTriggerConditions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.event_trigger_limits) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"EventTriggerLimits\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.object_type_name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ObjectTypeName\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.segment_filter) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SegmentFilter\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateEventTriggerOutput {
    var result: UpdateEventTriggerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateEventTriggerOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
