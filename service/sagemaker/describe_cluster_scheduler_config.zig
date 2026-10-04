const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeClusterSchedulerConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
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
