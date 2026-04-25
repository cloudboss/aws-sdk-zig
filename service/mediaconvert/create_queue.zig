const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const PricingPlan = @import("pricing_plan.zig").PricingPlan;
const ReservationPlanSettings = @import("reservation_plan_settings.zig").ReservationPlanSettings;
const QueueStatus = @import("queue_status.zig").QueueStatus;
const Queue = @import("queue.zig").Queue;

pub const CreateQueueInput = struct {
    /// Specify the maximum number of jobs your queue can process concurrently. For
    /// on-demand queues, the value you enter is constrained by your service quotas
    /// for Maximum concurrent jobs, per on-demand queue and Maximum concurrent
    /// jobs, per account. For reserved queues, specify the number of jobs you can
    /// process concurrently in your reservation plan instead.
    concurrent_jobs: ?i32 = null,

    /// Optional. A description of the queue that you are creating.
    description: ?[]const u8 = null,

    /// Specify the maximum number of Elemental Inference feeds MediaConvert can
    /// process concurrently.
    maximum_concurrent_feeds: ?i32 = null,

    /// The name of the queue that you are creating.
    name: []const u8,

    /// Specifies whether the pricing plan for the queue is on-demand or reserved.
    /// For on-demand, you pay per minute, billed in increments of .01 minute. For
    /// reserved, you pay for the transcoding capacity of the entire queue,
    /// regardless of how much or how little you use it. Reserved pricing requires a
    /// 12-month commitment. When you use the API to create a queue, the default is
    /// on-demand.
    pricing_plan: ?PricingPlan = null,

    /// Details about the pricing plan for your reserved queue. Required for
    /// reserved queues and not applicable to on-demand queues.
    reservation_plan_settings: ?ReservationPlanSettings = null,

    /// Initial state of the queue. If you create a paused queue, then jobs in that
    /// queue won't begin.
    status: ?QueueStatus = null,

    /// The tags that you want to add to the resource. You can tag resources with a
    /// key-value pair or with only a key.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .concurrent_jobs = "ConcurrentJobs",
        .description = "Description",
        .maximum_concurrent_feeds = "MaximumConcurrentFeeds",
        .name = "Name",
        .pricing_plan = "PricingPlan",
        .reservation_plan_settings = "ReservationPlanSettings",
        .status = "Status",
        .tags = "Tags",
    };
};

pub const CreateQueueOutput = struct {
    /// You can use queues to manage the resources that are available to your AWS
    /// account for running multiple transcoding jobs at the same time. If you don't
    /// specify a queue, the service sends all jobs through the default queue. For
    /// more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/working-with-queues.html.
    queue: ?Queue = null,

    pub const json_field_names = .{
        .queue = "Queue",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateQueueInput, options: CallOptions) !CreateQueueOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mediaconvert");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateQueueInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconvert", "MediaConvert", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/2017-08-29/queues";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.concurrent_jobs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConcurrentJobs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maximum_concurrent_feeds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaximumConcurrentFeeds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.pricing_plan) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PricingPlan\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.reservation_plan_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ReservationPlanSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Status\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateQueueOutput {
    var result: CreateQueueOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateQueueOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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
