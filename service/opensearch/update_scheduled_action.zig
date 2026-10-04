const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionType = @import("action_type.zig").ActionType;
const ScheduleAt = @import("schedule_at.zig").ScheduleAt;
const ScheduledAction = @import("scheduled_action.zig").ScheduledAction;

pub const UpdateScheduledActionInput = struct {
    /// The unique identifier of the action to reschedule. To retrieve this ID, send
    /// a
    /// [ListScheduledActions](https://docs.aws.amazon.com/opensearch-service/latest/APIReference/API_ListScheduledActions.html) request.
    action_id: []const u8,

    /// The type of action to reschedule. Can be one of `SERVICE_SOFTWARE_UPDATE`,
    /// `JVM_HEAP_SIZE_TUNING`, or `JVM_YOUNG_GEN_TUNING`. To retrieve
    /// this value, send a
    /// [ListScheduledActions](https://docs.aws.amazon.com/opensearch-service/latest/APIReference/API_ListScheduledActions.html) request.
    action_type: ActionType,

    /// The time to implement the change, in Coordinated Universal Time (UTC). Only
    /// specify
    /// this parameter if you set `ScheduleAt` to `TIMESTAMP`.
    desired_start_time: ?i64 = null,

    /// The name of the domain to reschedule an action for.
    domain_name: []const u8,

    /// When to schedule the action.
    ///
    /// * `NOW` - Immediately schedules the update to happen in the current
    /// hour if there's capacity available.
    ///
    /// * `TIMESTAMP` - Lets you specify a custom date and time to apply the
    /// update. If you specify this value, you must also provide a value for
    /// `DesiredStartTime`.
    ///
    /// * `OFF_PEAK_WINDOW` - Marks the action to be picked up during an
    /// upcoming off-peak window. There's no guarantee that the change will be
    /// implemented during the next immediate window. Depending on capacity, it
    /// might
    /// happen in subsequent days.
    schedule_at: ScheduleAt,

    pub const json_field_names = .{
        .action_id = "ActionID",
        .action_type = "ActionType",
        .desired_start_time = "DesiredStartTime",
        .domain_name = "DomainName",
        .schedule_at = "ScheduleAt",
    };
};

pub const UpdateScheduledActionOutput = struct {
    /// Information about the rescheduled action.
    scheduled_action: ?ScheduledAction = null,

    pub const json_field_names = .{
        .scheduled_action = "ScheduledAction",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateScheduledActionInput, options: CallOptions) !UpdateScheduledActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateScheduledActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/opensearch/domain/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/scheduledAction/update");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ActionID\":");
    try aws.json.writeValue(@TypeOf(input.action_id), input.action_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ActionType\":");
    try aws.json.writeValue(@TypeOf(input.action_type), input.action_type, allocator, &body_buf);
    has_prev = true;
    if (input.desired_start_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DesiredStartTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ScheduleAt\":");
    try aws.json.writeValue(@TypeOf(input.schedule_at), input.schedule_at, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateScheduledActionOutput {
    const result: UpdateScheduledActionOutput = try aws.json.parseJsonObject(
        UpdateScheduledActionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
