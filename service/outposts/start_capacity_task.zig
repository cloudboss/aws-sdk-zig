const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const InstanceTypeCapacity = @import("instance_type_capacity.zig").InstanceTypeCapacity;
const InstancesToExclude = @import("instances_to_exclude.zig").InstancesToExclude;
const TaskActionOnBlockingInstances = @import("task_action_on_blocking_instances.zig").TaskActionOnBlockingInstances;
const CapacityTaskStatus = @import("capacity_task_status.zig").CapacityTaskStatus;
const CapacityTaskFailure = @import("capacity_task_failure.zig").CapacityTaskFailure;

pub const StartCapacityTaskInput = struct {
    /// The ID of the Outpost asset. An Outpost asset can be a single server within
    /// an Outposts
    /// rack or an Outposts server configuration.
    asset_id: ?[]const u8 = null,

    /// You can request a dry run to determine if the instance type and instance
    /// size changes is
    /// above or below available instance capacity. Requesting a dry run does not
    /// make any changes to
    /// your plan.
    dry_run: ?bool = null,

    /// The instance pools specified in the capacity task.
    instance_pools: []const InstanceTypeCapacity,

    /// List of user-specified running instances that must not be stopped in order
    /// to free up the
    /// capacity needed to run the capacity task.
    instances_to_exclude: ?InstancesToExclude = null,

    /// The ID of the Amazon Web Services Outposts order associated with the
    /// specified capacity task.
    order_id: ?[]const u8 = null,

    /// The ID or ARN of the Outposts associated with the specified capacity task.
    outpost_identifier: []const u8,

    /// Specify one of the following options in case an instance is blocking the
    /// capacity task
    /// from running.
    ///
    /// * `WAIT_FOR_EVACUATION` - Checks every 10 minutes over 48 hours to determine
    /// if instances have stopped and capacity is available to complete the task.
    ///
    /// * `FAIL_TASK` - The capacity task fails.
    task_action_on_blocking_instances: ?TaskActionOnBlockingInstances = null,

    pub const json_field_names = .{
        .asset_id = "AssetId",
        .dry_run = "DryRun",
        .instance_pools = "InstancePools",
        .instances_to_exclude = "InstancesToExclude",
        .order_id = "OrderId",
        .outpost_identifier = "OutpostIdentifier",
        .task_action_on_blocking_instances = "TaskActionOnBlockingInstances",
    };
};

pub const StartCapacityTaskOutput = struct {
    /// The ID of the asset. An Outpost asset can be a single server within an
    /// Outposts rack or an
    /// Outposts server configuration.
    asset_id: ?[]const u8 = null,

    /// ID of the capacity task that you want to start.
    capacity_task_id: ?[]const u8 = null,

    /// Status of the specified capacity task.
    capacity_task_status: ?CapacityTaskStatus = null,

    /// Date that the specified capacity task ran successfully.
    completion_date: ?i64 = null,

    /// Date that the specified capacity task was created.
    creation_date: ?i64 = null,

    /// Results of the dry run showing if the specified capacity task is above or
    /// below the
    /// available instance capacity.
    dry_run: ?bool = null,

    /// Reason that the specified capacity task failed.
    failed: ?CapacityTaskFailure = null,

    /// User-specified instances that must not be stopped in order to free up the
    /// capacity needed
    /// to run the capacity task.
    instances_to_exclude: ?InstancesToExclude = null,

    /// Date that the specified capacity task was last modified.
    last_modified_date: ?i64 = null,

    /// ID of the Amazon Web Services Outposts order of the host associated with the
    /// capacity task.
    order_id: ?[]const u8 = null,

    /// ID of the Outpost associated with the capacity task.
    outpost_id: ?[]const u8 = null,

    /// List of the instance pools requested in the specified capacity task.
    requested_instance_pools: ?[]const InstanceTypeCapacity = null,

    /// User-specified option in case an instance is blocking the capacity task from
    /// running.
    ///
    /// * `WAIT_FOR_EVACUATION` - Checks every 10 minutes over 48 hours to determine
    /// if instances have stopped and capacity is available to complete the task.
    ///
    /// * `FAIL_TASK` - The capacity task fails.
    task_action_on_blocking_instances: ?TaskActionOnBlockingInstances = null,

    pub const json_field_names = .{
        .asset_id = "AssetId",
        .capacity_task_id = "CapacityTaskId",
        .capacity_task_status = "CapacityTaskStatus",
        .completion_date = "CompletionDate",
        .creation_date = "CreationDate",
        .dry_run = "DryRun",
        .failed = "Failed",
        .instances_to_exclude = "InstancesToExclude",
        .last_modified_date = "LastModifiedDate",
        .order_id = "OrderId",
        .outpost_id = "OutpostId",
        .requested_instance_pools = "RequestedInstancePools",
        .task_action_on_blocking_instances = "TaskActionOnBlockingInstances",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartCapacityTaskInput, options: CallOptions) !StartCapacityTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "outposts");

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartCapacityTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("outposts", "Outposts", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/outposts/");
    try path_buf.appendSlice(allocator, input.outpost_identifier);
    try path_buf.appendSlice(allocator, "/capacity");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.asset_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AssetId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dry_run) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DryRun\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InstancePools\":");
    try aws.json.writeValue(@TypeOf(input.instance_pools), input.instance_pools, allocator, &body_buf);
    has_prev = true;
    if (input.instances_to_exclude) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InstancesToExclude\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.order_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OrderId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.task_action_on_blocking_instances) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TaskActionOnBlockingInstances\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartCapacityTaskOutput {
    var result: StartCapacityTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartCapacityTaskOutput, body, allocator);
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
