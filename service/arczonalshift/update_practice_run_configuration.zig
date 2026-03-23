const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ControlCondition = @import("control_condition.zig").ControlCondition;
const PracticeRunConfiguration = @import("practice_run_configuration.zig").PracticeRunConfiguration;
const ZonalAutoshiftStatus = @import("zonal_autoshift_status.zig").ZonalAutoshiftStatus;

pub const UpdatePracticeRunConfigurationInput = struct {
    /// Add, change, or remove windows of days and times for when you can,
    /// optionally, allow ARC to start a practice run for a resource.
    ///
    /// The format for allowed windows is: DAY:HH:SS-DAY:HH:SS. Keep in mind, when
    /// you specify dates, that dates and times for practice runs are in UTC. Also,
    /// be aware of potential time adjustments that might be required for daylight
    /// saving time differences. Separate multiple allowed windows with spaces.
    ///
    /// For example, say you want to allow practice runs only on Wednesdays and
    /// Fridays from noon to 5 p.m. For this scenario, you could set the following
    /// recurring days and times as allowed windows, for example:
    /// `Wed-12:00-Wed:17:00 Fri-12:00-Fri:17:00`.
    ///
    /// The `allowedWindows` have to start and end on the same day. Windows that
    /// span multiple days aren't supported.
    allowed_windows: ?[]const []const u8 = null,

    /// Add, change, or remove blocked dates for a practice run in zonal autoshift.
    ///
    /// Optionally, you can block practice runs for specific calendar dates. The
    /// format for blocked dates is: YYYY-MM-DD. Keep in mind, when you specify
    /// dates, that dates and times for practice runs are in UTC. Separate multiple
    /// blocked dates with spaces.
    ///
    /// For example, if you have an application update scheduled to launch on May 1,
    /// 2024, and you don't want practice runs to shift traffic away at that time,
    /// you could set a blocked date for `2024-05-01`.
    blocked_dates: ?[]const []const u8 = null,

    /// Add, change, or remove windows of days and times for when you can,
    /// optionally, block ARC from starting a practice run for a resource.
    ///
    /// The format for blocked windows is: DAY:HH:SS-DAY:HH:SS. Keep in mind, when
    /// you specify dates, that dates and times for practice runs are in UTC. Also,
    /// be aware of potential time adjustments that might be required for daylight
    /// saving time differences. Separate multiple blocked windows with spaces.
    ///
    /// For example, say you run business report summaries three days a week. For
    /// this scenario, you might set the following recurring days and times as
    /// blocked windows, for example: `MON-20:30-21:30 WED-20:30-21:30
    /// FRI-20:30-21:30`.
    blocked_windows: ?[]const []const u8 = null,

    /// Add, change, or remove the Amazon CloudWatch alarms that you optionally
    /// specify as the blocking alarms for practice runs.
    blocking_alarms: ?[]const ControlCondition = null,

    /// Specify one or more Amazon CloudWatch alarms as the outcome alarms for
    /// practice runs.
    outcome_alarms: ?[]const ControlCondition = null,

    /// The identifier for the resource that you want to update the practice run
    /// configuration for. The identifier is the Amazon Resource Name (ARN) for the
    /// resource.
    resource_identifier: []const u8,

    pub const json_field_names = .{
        .allowed_windows = "allowedWindows",
        .blocked_dates = "blockedDates",
        .blocked_windows = "blockedWindows",
        .blocking_alarms = "blockingAlarms",
        .outcome_alarms = "outcomeAlarms",
        .resource_identifier = "resourceIdentifier",
    };
};

pub const UpdatePracticeRunConfigurationOutput = struct {
    /// The Amazon Resource Name (ARN) of the resource that you updated the practice
    /// run for.
    arn: []const u8,

    /// The name of the resource that you updated the practice run for.
    name: []const u8,

    /// The practice run configuration that was updated.
    practice_run_configuration: ?PracticeRunConfiguration = null,

    /// The zonal autoshift status for the resource that you updated the practice
    /// run for.
    zonal_autoshift_status: ZonalAutoshiftStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
        .practice_run_configuration = "practiceRunConfiguration",
        .zonal_autoshift_status = "zonalAutoshiftStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePracticeRunConfigurationInput, options: CallOptions) !UpdatePracticeRunConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "percdataplane");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePracticeRunConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("arc-zonal-shift", "ARC Zonal Shift", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/configuration/");
    try path_buf.appendSlice(allocator, input.resource_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.allowed_windows) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"allowedWindows\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.blocked_dates) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"blockedDates\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.blocked_windows) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"blockedWindows\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.blocking_alarms) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"blockingAlarms\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.outcome_alarms) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"outcomeAlarms\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePracticeRunConfigurationOutput {
    var result: UpdatePracticeRunConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdatePracticeRunConfigurationOutput, body, allocator);
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
