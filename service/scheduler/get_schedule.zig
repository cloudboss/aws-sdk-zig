const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ActionAfterCompletion = @import("action_after_completion.zig").ActionAfterCompletion;
const FlexibleTimeWindow = @import("flexible_time_window.zig").FlexibleTimeWindow;
const ScheduleState = @import("schedule_state.zig").ScheduleState;
const Target = @import("target.zig").Target;

pub const GetScheduleInput = struct {
    /// The name of the schedule group associated with this schedule. If you omit
    /// this, EventBridge Scheduler assumes that the schedule is associated with the
    /// default group.
    group_name: ?[]const u8 = null,

    /// The name of the schedule to retrieve.
    name: []const u8,

    pub const json_field_names = .{
        .group_name = "GroupName",
        .name = "Name",
    };
};

pub const GetScheduleOutput = struct {
    /// Indicates the action that EventBridge Scheduler applies to the schedule
    /// after the schedule completes invoking the target.
    action_after_completion: ?ActionAfterCompletion = null,

    /// The Amazon Resource Name (ARN) of the schedule.
    arn: ?[]const u8 = null,

    /// The time at which the schedule was created.
    creation_date: ?i64 = null,

    /// The description of the schedule.
    description: ?[]const u8 = null,

    /// The date, in UTC, before which the schedule can invoke its target. Depending
    /// on the schedule's recurrence expression, invocations might stop on, or
    /// before, the `EndDate` you specify.
    /// EventBridge Scheduler ignores `EndDate` for one-time schedules.
    end_date: ?i64 = null,

    /// Allows you to configure a time window during which EventBridge Scheduler
    /// invokes the schedule.
    flexible_time_window: ?FlexibleTimeWindow = null,

    /// The name of the schedule group associated with this schedule.
    group_name: ?[]const u8 = null,

    /// The ARN for a customer managed KMS Key that is be used to encrypt and
    /// decrypt your data.
    kms_key_arn: ?[]const u8 = null,

    /// The time at which the schedule was last modified.
    last_modification_date: ?i64 = null,

    /// The name of the schedule.
    name: ?[]const u8 = null,

    /// The expression that defines when the schedule runs. The following formats
    /// are supported.
    ///
    /// * `at` expression - `at(yyyy-mm-ddThh:mm:ss)`
    ///
    /// * `rate` expression - `rate(value unit)`
    ///
    /// * `cron` expression - `cron(fields)`
    ///
    /// You can use `at` expressions to create one-time schedules that invoke a
    /// target once, at the time and in the time zone, that you specify.
    /// You can use `rate` and `cron` expressions to create recurring schedules.
    /// Rate-based schedules are useful when you want to invoke a target
    /// at regular intervals, such as every 15 minutes or every five days.
    /// Cron-based schedules are useful when you want to invoke a target
    /// periodically at a specific time,
    /// such as at 8:00 am (UTC+0) every 1st day of the month.
    ///
    /// A `cron` expression consists of six fields separated by white spaces:
    /// `(minutes hours day_of_month month day_of_week year)`.
    ///
    /// A `rate` expression consists of a *value* as a positive integer, and a
    /// *unit* with the following options:
    /// `minute` | `minutes` | `hour` | `hours` | `day` | `days`
    ///
    /// For more information and examples, see [Schedule types on EventBridge
    /// Scheduler](https://docs.aws.amazon.com/scheduler/latest/UserGuide/schedule-types.html) in the *EventBridge Scheduler User Guide*.
    schedule_expression: ?[]const u8 = null,

    /// The timezone in which the scheduling expression is evaluated.
    schedule_expression_timezone: ?[]const u8 = null,

    /// The date, in UTC, after which the schedule can begin invoking its target.
    /// Depending on the schedule's recurrence expression, invocations might occur
    /// on, or after, the `StartDate` you specify.
    /// EventBridge Scheduler ignores `StartDate` for one-time schedules.
    start_date: ?i64 = null,

    /// Specifies whether the schedule is enabled or disabled.
    state: ?ScheduleState = null,

    /// The schedule target.
    target: ?Target = null,

    pub const json_field_names = .{
        .action_after_completion = "ActionAfterCompletion",
        .arn = "Arn",
        .creation_date = "CreationDate",
        .description = "Description",
        .end_date = "EndDate",
        .flexible_time_window = "FlexibleTimeWindow",
        .group_name = "GroupName",
        .kms_key_arn = "KmsKeyArn",
        .last_modification_date = "LastModificationDate",
        .name = "Name",
        .schedule_expression = "ScheduleExpression",
        .schedule_expression_timezone = "ScheduleExpressionTimezone",
        .start_date = "StartDate",
        .state = "State",
        .target = "Target",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetScheduleInput, options: Options) !GetScheduleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "scheduler");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetScheduleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("scheduler", "Scheduler", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/schedules/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.group_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "groupName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetScheduleOutput {
    var result: GetScheduleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetScheduleOutput, body, allocator);
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
