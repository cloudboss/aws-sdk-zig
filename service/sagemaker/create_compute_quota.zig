const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActivationState = @import("activation_state.zig").ActivationState;
const ComputeQuotaConfig = @import("compute_quota_config.zig").ComputeQuotaConfig;
const ComputeQuotaTarget = @import("compute_quota_target.zig").ComputeQuotaTarget;
const Tag = @import("tag.zig").Tag;

pub const CreateComputeQuotaInput = struct {
    /// The state of the compute allocation being described. Use to enable or
    /// disable compute allocation.
    ///
    /// Default is `Enabled`.
    activation_state: ?ActivationState = null,

    /// ARN of the cluster.
    cluster_arn: []const u8,

    /// Configuration of the compute allocation definition. This includes the
    /// resource sharing option, and the setting to preempt low priority tasks.
    compute_quota_config: ComputeQuotaConfig,

    /// The target entity to allocate compute resources to.
    compute_quota_target: ComputeQuotaTarget,

    /// Description of the compute allocation definition.
    description: ?[]const u8 = null,

    /// The name of the compute allocation definition. The name must be unique
    /// within the SageMaker AI HyperPod cluster specified by `ClusterArn`. You can
    /// use the same name in other clusters within a Region or across Regions.
    name: []const u8,

    /// Tags of the compute allocation definition.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .activation_state = "ActivationState",
        .cluster_arn = "ClusterArn",
        .compute_quota_config = "ComputeQuotaConfig",
        .compute_quota_target = "ComputeQuotaTarget",
        .description = "Description",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateComputeQuotaOutput = struct {
    /// ARN of the compute allocation definition.
    compute_quota_arn: []const u8,

    /// ID of the compute allocation definition.
    compute_quota_id: []const u8,

    pub const json_field_names = .{
        .compute_quota_arn = "ComputeQuotaArn",
        .compute_quota_id = "ComputeQuotaId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateComputeQuotaInput, options: CallOptions) !CreateComputeQuotaOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateComputeQuotaInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateComputeQuota");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateComputeQuotaOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateComputeQuotaOutput, body, allocator);
}
