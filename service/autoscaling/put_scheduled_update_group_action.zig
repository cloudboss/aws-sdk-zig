const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const PutScheduledUpdateGroupActionInput = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: []const u8,

    /// The desired capacity is the initial capacity of the Auto Scaling group after
    /// the scheduled
    /// action runs and the capacity it attempts to maintain. It can scale beyond
    /// this capacity
    /// if you add more scaling conditions.
    ///
    /// You must specify at least one of the following properties: `MaxSize`,
    /// `MinSize`, or `DesiredCapacity`.
    desired_capacity: ?i32 = null,

    /// The date and time for the recurring schedule to end, in UTC. For example,
    /// `"2021-06-01T00:00:00Z"`.
    end_time: ?i64 = null,

    /// The maximum size of the Auto Scaling group.
    max_size: ?i32 = null,

    /// The minimum size of the Auto Scaling group.
    min_size: ?i32 = null,

    /// The recurring schedule for this action. This format consists of five fields
    /// separated
    /// by white spaces: [Minute] [Hour] [Day_of_Month] [Month_of_Year]
    /// [Day_of_Week]. The value
    /// must be in quotes (for example, `"30 0 1 1,6,12 *"`). For more information
    /// about this format, see [Crontab](http://crontab.org).
    ///
    /// When `StartTime` and `EndTime` are specified with
    /// `Recurrence`, they form the boundaries of when the recurring action
    /// starts and stops.
    ///
    /// Cron expressions use Universal Coordinated Time (UTC) by default.
    recurrence: ?[]const u8 = null,

    /// The name of this scaling action.
    scheduled_action_name: []const u8,

    /// The date and time for this action to start, in YYYY-MM-DDThh:mm:ssZ format
    /// in UTC/GMT
    /// only and in quotes (for example, `"2021-06-01T00:00:00Z"`).
    ///
    /// If you specify `Recurrence` and `StartTime`, Amazon EC2 Auto Scaling
    /// performs
    /// the action at this time, and then performs the action based on the specified
    /// recurrence.
    start_time: ?i64 = null,

    /// This property is no longer used.
    time: ?i64 = null,

    /// Specifies the time zone for a cron expression. If a time zone is not
    /// provided, UTC is
    /// used by default.
    ///
    /// Valid values are the canonical names of the IANA time zones, derived from
    /// the IANA
    /// Time Zone Database (such as `Etc/GMT+9` or `Pacific/Tahiti`). For
    /// more information, see
    /// [https://en.wikipedia.org/wiki/List_of_tz_database_time_zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).
    time_zone: ?[]const u8 = null,
};

const PutScheduledUpdateGroupActionOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutScheduledUpdateGroupActionInput, options: Options) !PutScheduledUpdateGroupActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "autoscaling");

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutScheduledUpdateGroupActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=PutScheduledUpdateGroupAction&Version=2011-01-01");
    try body_buf.appendSlice(allocator, "&AutoScalingGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.auto_scaling_group_name);
    if (input.desired_capacity) |v| {
        try body_buf.appendSlice(allocator, "&DesiredCapacity=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.end_time) |v| {
        try body_buf.appendSlice(allocator, "&EndTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.max_size) |v| {
        try body_buf.appendSlice(allocator, "&MaxSize=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.min_size) |v| {
        try body_buf.appendSlice(allocator, "&MinSize=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.recurrence) |v| {
        try body_buf.appendSlice(allocator, "&Recurrence=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&ScheduledActionName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.scheduled_action_name);
    if (input.start_time) |v| {
        try body_buf.appendSlice(allocator, "&StartTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.time) |v| {
        try body_buf.appendSlice(allocator, "&Time=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.time_zone) |v| {
        try body_buf.appendSlice(allocator, "&TimeZone=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutScheduledUpdateGroupActionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: PutScheduledUpdateGroupActionOutput = .{};

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "ActiveInstanceRefreshNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .active_instance_refresh_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchError")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InstanceRefreshInProgressFault")) {
        return .{ .arena = arena, .kind = .{ .instance_refresh_in_progress_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextToken")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IrreversibleInstanceRefreshFault")) {
        return .{ .arena = arena, .kind = .{ .irreversible_instance_refresh_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceContentionFault")) {
        return .{ .arena = arena, .kind = .{ .resource_contention_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseFault")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ScalingActivityInProgressFault")) {
        return .{ .arena = arena, .kind = .{ .scaling_activity_in_progress_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceLinkedRoleFailure")) {
        return .{ .arena = arena, .kind = .{ .service_linked_role_failure = .{
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
