const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const UserContext = @import("user_context.zig").UserContext;
const SchedulerConfig = @import("scheduler_config.zig").SchedulerConfig;
const SchedulerResourceStatus = @import("scheduler_resource_status.zig").SchedulerResourceStatus;

pub const DescribeClusterSchedulerConfigInput = struct {
    /// ID of the cluster policy.
    cluster_scheduler_config_id: []const u8,

    /// Version of the cluster policy.
    cluster_scheduler_config_version: ?i32 = null,

    pub const json_field_names = .{
        .cluster_scheduler_config_id = "ClusterSchedulerConfigId",
        .cluster_scheduler_config_version = "ClusterSchedulerConfigVersion",
    };
};

pub const DescribeClusterSchedulerConfigOutput = struct {
    /// ARN of the cluster where the cluster policy is applied.
    cluster_arn: ?[]const u8 = null,

    /// ARN of the cluster policy.
    cluster_scheduler_config_arn: []const u8,

    /// ID of the cluster policy.
    cluster_scheduler_config_id: []const u8,

    /// Version of the cluster policy.
    cluster_scheduler_config_version: i32,

    created_by: ?UserContext = null,

    /// Creation time of the cluster policy.
    creation_time: i64,

    /// Description of the cluster policy.
    description: ?[]const u8 = null,

    /// Failure reason of the cluster policy.
    failure_reason: ?[]const u8 = null,

    last_modified_by: ?UserContext = null,

    /// Last modified time of the cluster policy.
    last_modified_time: ?i64 = null,

    /// Name of the cluster policy.
    name: []const u8,

    /// Cluster policy configuration. This policy is used for task prioritization
    /// and fair-share allocation. This helps prioritize critical workloads and
    /// distributes idle compute across entities.
    scheduler_config: ?SchedulerConfig = null,

    /// Status of the cluster policy.
    status: SchedulerResourceStatus,

    /// Additional details about the status of the cluster policy. This field
    /// provides context when the policy is in a non-active state, such as during
    /// creation, updates, or if failures occur.
    status_details: ?[]const aws.map.MapEntry(SchedulerResourceStatus) = null,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .cluster_scheduler_config_arn = "ClusterSchedulerConfigArn",
        .cluster_scheduler_config_id = "ClusterSchedulerConfigId",
        .cluster_scheduler_config_version = "ClusterSchedulerConfigVersion",
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .description = "Description",
        .failure_reason = "FailureReason",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .scheduler_config = "SchedulerConfig",
        .status = "Status",
        .status_details = "StatusDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeClusterSchedulerConfigInput, options: CallOptions) !DescribeClusterSchedulerConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeClusterSchedulerConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeClusterSchedulerConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeClusterSchedulerConfigOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeClusterSchedulerConfigOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
