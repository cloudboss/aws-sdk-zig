const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const QuotaShareCapacityLimit = @import("quota_share_capacity_limit.zig").QuotaShareCapacityLimit;
const QuotaSharePreemptionConfiguration = @import("quota_share_preemption_configuration.zig").QuotaSharePreemptionConfiguration;
const QuotaShareResourceSharingConfiguration = @import("quota_share_resource_sharing_configuration.zig").QuotaShareResourceSharingConfiguration;
const QuotaShareState = @import("quota_share_state.zig").QuotaShareState;

pub const CreateQuotaShareInput = struct {
    /// A list that specifies the quantity and type of compute capacity allocated to
    /// the quota share.
    capacity_limits: []const QuotaShareCapacityLimit,

    /// The Batch job queue associated with the quota share. This can be the job
    /// queue name or ARN.
    /// A job queue must be in the `VALID` state before you can associate it with a
    /// quota share.
    job_queue: []const u8,

    /// Specifies the preemption behavior for jobs in a quota share.
    preemption_configuration: QuotaSharePreemptionConfiguration,

    /// The name of the quota share. It can be up to 128 characters long. It can
    /// contain uppercase and
    /// lowercase letters, numbers, hyphens (-), and underscores (_).
    quota_share_name: []const u8,

    /// Specifies whether a quota share reserves, lends, or both lends and borrows
    /// idle compute capacity.
    resource_sharing_configuration: QuotaShareResourceSharingConfiguration,

    /// The state of the quota share. If the quota share is `ENABLED`, it is able to
    /// accept jobs.
    /// If the quota share is `DISABLED`, new jobs won't be accepted but jobs
    /// already submitted can finish.
    /// The default state is `ENABLED`.
    state: ?QuotaShareState = null,

    /// The tags that you apply to the quota share to help you categorize and
    /// organize your
    /// resources. Each tag consists of a key and an optional value. For more
    /// information, see [Tagging your Batch
    /// resources](https://docs.aws.amazon.com/batch/latest/userguide/using-tags.html)
    /// in *Batch User Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .capacity_limits = "capacityLimits",
        .job_queue = "jobQueue",
        .preemption_configuration = "preemptionConfiguration",
        .quota_share_name = "quotaShareName",
        .resource_sharing_configuration = "resourceSharingConfiguration",
        .state = "state",
        .tags = "tags",
    };
};

pub const CreateQuotaShareOutput = struct {
    /// The Amazon Resource Name (ARN) of the quota share.
    quota_share_arn: ?[]const u8 = null,

    /// The name of the quota share.
    quota_share_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .quota_share_arn = "quotaShareArn",
        .quota_share_name = "quotaShareName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateQuotaShareInput, options: CallOptions) !CreateQuotaShareOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "batch");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateQuotaShareInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/createquotashare";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"capacityLimits\":");
    try aws.json.writeValue(@TypeOf(input.capacity_limits), input.capacity_limits, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobQueue\":");
    try aws.json.writeValue(@TypeOf(input.job_queue), input.job_queue, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"preemptionConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.preemption_configuration), input.preemption_configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"quotaShareName\":");
    try aws.json.writeValue(@TypeOf(input.quota_share_name), input.quota_share_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceSharingConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.resource_sharing_configuration), input.resource_sharing_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"state\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateQuotaShareOutput {
    var result: CreateQuotaShareOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateQuotaShareOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ClientException")) {
        return .{ .arena = arena, .kind = .{ .client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerException")) {
        return .{ .arena = arena, .kind = .{ .server_exception = .{
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
