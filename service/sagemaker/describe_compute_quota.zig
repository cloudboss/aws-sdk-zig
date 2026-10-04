const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActivationState = @import("activation_state.zig").ActivationState;
const ComputeQuotaConfig = @import("compute_quota_config.zig").ComputeQuotaConfig;
const ComputeQuotaTarget = @import("compute_quota_target.zig").ComputeQuotaTarget;
const UserContext = @import("user_context.zig").UserContext;
const SchedulerResourceStatus = @import("scheduler_resource_status.zig").SchedulerResourceStatus;

pub const DescribeComputeQuotaInput = struct {
    /// ID of the compute allocation definition.
    compute_quota_id: []const u8,

    /// Version of the compute allocation definition.
    compute_quota_version: ?i32 = null,

    pub const json_field_names = .{
        .compute_quota_id = "ComputeQuotaId",
        .compute_quota_version = "ComputeQuotaVersion",
    };
};

pub const DescribeComputeQuotaOutput = struct {
    /// The state of the compute allocation being described. Use to enable or
    /// disable compute allocation.
    ///
    /// Default is `Enabled`.
    activation_state: ?ActivationState = null,

    /// ARN of the cluster.
    cluster_arn: ?[]const u8 = null,

    /// ARN of the compute allocation definition.
    compute_quota_arn: []const u8,

    /// Configuration of the compute allocation definition. This includes the
    /// resource sharing option, and the setting to preempt low priority tasks.
    compute_quota_config: ?ComputeQuotaConfig = null,

    /// ID of the compute allocation definition.
    compute_quota_id: []const u8,

    /// The target entity to allocate compute resources to.
    compute_quota_target: ?ComputeQuotaTarget = null,

    /// Version of the compute allocation definition.
    compute_quota_version: i32,

    created_by: ?UserContext = null,

    /// Creation time of the compute allocation configuration.
    creation_time: i64,

    /// Description of the compute allocation definition.
    description: ?[]const u8 = null,

    /// Failure reason of the compute allocation definition.
    failure_reason: ?[]const u8 = null,

    last_modified_by: ?UserContext = null,

    /// Last modified time of the compute allocation configuration.
    last_modified_time: ?i64 = null,

    /// Name of the compute allocation definition.
    name: []const u8,

    /// Status of the compute allocation definition.
    status: SchedulerResourceStatus,

    pub const json_field_names = .{
        .activation_state = "ActivationState",
        .cluster_arn = "ClusterArn",
        .compute_quota_arn = "ComputeQuotaArn",
        .compute_quota_config = "ComputeQuotaConfig",
        .compute_quota_id = "ComputeQuotaId",
        .compute_quota_target = "ComputeQuotaTarget",
        .compute_quota_version = "ComputeQuotaVersion",
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .description = "Description",
        .failure_reason = "FailureReason",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeComputeQuotaInput, options: CallOptions) !DescribeComputeQuotaOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeComputeQuotaInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeComputeQuota");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeComputeQuotaOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeComputeQuotaOutput, body, allocator);
}
