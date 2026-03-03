const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ControlCondition = @import("control_condition.zig").ControlCondition;
const PracticeRunConfiguration = @import("practice_run_configuration.zig").PracticeRunConfiguration;
const ZonalAutoshiftStatus = @import("zonal_autoshift_status.zig").ZonalAutoshiftStatus;

pub const CreatePracticeRunConfigurationInput = struct {
    /// Optionally, you can allow ARC to start practice runs for specific windows of
    /// days and times.
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

    /// Optionally, you can block ARC from starting practice runs for a resource on
    /// specific calendar dates.
    ///
    /// The format for blocked dates is: YYYY-MM-DD. Keep in mind, when you specify
    /// dates, that dates and times for practice runs are in UTC. Separate multiple
    /// blocked dates with spaces.
    ///
    /// For example, if you have an application update scheduled to launch on May 1,
    /// 2024, and you don't want practice runs to shift traffic away at that time,
    /// you could set a blocked date for `2024-05-01`.
    blocked_dates: ?[]const []const u8 = null,

    /// Optionally, you can block ARC from starting practice runs for specific
    /// windows of days and times.
    ///
    /// The format for blocked windows is: DAY:HH:SS-DAY:HH:SS. Keep in mind, when
    /// you specify dates, that dates and times for practice runs are in UTC. Also,
    /// be aware of potential time adjustments that might be required for daylight
    /// saving time differences. Separate multiple blocked windows with spaces.
    ///
    /// For example, say you run business report summaries three days a week. For
    /// this scenario, you could set the following recurring days and times as
    /// blocked windows, for example: `Mon:00:00-Mon:10:00 Wed-20:30-Wed:21:30
    /// Fri-20:30-Fri:21:30`.
    ///
    /// The `blockedWindows` have to start and end on the same day. Windows that
    /// span multiple days aren't supported.
    blocked_windows: ?[]const []const u8 = null,

    /// *Blocking alarms* for practice runs are optional alarms that you can specify
    /// that block practice runs when one or more of the alarms is in an `ALARM`
    /// state.
    blocking_alarms: ?[]const ControlCondition = null,

    /// *Outcome alarms* for practice runs are alarms that you specify that end a
    /// practice run when one or more of the alarms is in an `ALARM` state.
    ///
    /// Configure one or more of these alarms to monitor the health of your
    /// application when traffic is shifted away from an Availability Zone during
    /// each practice run. You should configure these alarms to go into an `ALARM`
    /// state if you want to stop a zonal shift, to let traffic for the resource
    /// return to the original Availability Zone.
    outcome_alarms: []const ControlCondition,

    /// The identifier of the resource that Amazon Web Services shifts traffic for
    /// with a practice run zonal shift. The identifier is the Amazon Resource Name
    /// (ARN) for the resource.
    ///
    /// Amazon Application Recovery Controller currently supports enabling the
    /// following resources for zonal shift and zonal autoshift:
    ///
    /// * [Amazon EC2 Auto Scaling
    ///   groups](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.ec2-auto-scaling-groups.html)
    /// * [Amazon Elastic Kubernetes
    ///   Service](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.eks.html)
    /// * [Application Load
    ///   Balancer](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.app-load-balancers.html)
    /// * [Network Load
    ///   Balancer](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.network-load-balancers.html)
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

pub const CreatePracticeRunConfigurationOutput = struct {
    /// The Amazon Resource Name (ARN) of the resource that you configured the
    /// practice run for.
    arn: []const u8,

    /// The name of the resource that you configured the practice run for.
    name: []const u8,

    /// A practice run configuration for a resource. Configurations include the
    /// outcome alarm that you specify for practice runs, and, optionally, a
    /// blocking alarm and blocking dates and windows.
    practice_run_configuration: ?PracticeRunConfiguration = null,

    /// The status for zonal autoshift for a resource. When you specify `ENABLED`
    /// for the autoshift status, Amazon Web Services shifts traffic away from
    /// shifts away application resource traffic from an Availability Zone, on your
    /// behalf, when internal telemetry indicates that there is an Availability Zone
    /// impairment that could potentially impact customers.
    ///
    /// When you enable zonal autoshift, you must also configure practice runs for
    /// the resource.
    zonal_autoshift_status: ZonalAutoshiftStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
        .practice_run_configuration = "practiceRunConfiguration",
        .zonal_autoshift_status = "zonalAutoshiftStatus",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePracticeRunConfigurationInput, options: Options) !CreatePracticeRunConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "arczonalshift");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePracticeRunConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("arczonalshift", "ARC Zonal Shift", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/configuration";

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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"outcomeAlarms\":");
    try aws.json.writeValue(@TypeOf(input.outcome_alarms), input.outcome_alarms, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.resource_identifier), input.resource_identifier, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePracticeRunConfigurationOutput {
    var result: CreatePracticeRunConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePracticeRunConfigurationOutput, body, allocator);
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
