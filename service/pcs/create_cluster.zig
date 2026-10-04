const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NetworkingRequest = @import("networking_request.zig").NetworkingRequest;
const SchedulerRequest = @import("scheduler_request.zig").SchedulerRequest;
const Size = @import("size.zig").Size;
const ClusterSlurmConfigurationRequest = @import("cluster_slurm_configuration_request.zig").ClusterSlurmConfigurationRequest;
const Cluster = @import("cluster.zig").Cluster;

pub const CreateClusterInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. Idempotency ensures that an API request
    /// completes only once. With an idempotent request, if the original request
    /// completes successfully, the subsequent retries with the same client token
    /// return the result from the original successful request and they have no
    /// additional effect. If you don't specify a client token, the CLI and SDK
    /// automatically generate 1 for you.
    client_token: ?[]const u8 = null,

    /// A name to identify the cluster. Example: `MyCluster`
    cluster_name: []const u8,

    /// The networking configuration used to set up the cluster's control plane.
    networking: NetworkingRequest,

    /// The cluster management and job scheduling software associated with the
    /// cluster.
    scheduler: SchedulerRequest,

    /// A value that determines the maximum number of compute nodes in the cluster
    /// and the maximum number of jobs (active and queued).
    ///
    /// * `SMALL`: 32 compute nodes and 256 jobs
    /// * `MEDIUM`: 512 compute nodes and 8192 jobs
    /// * `LARGE`: 2048 compute nodes and 16,384 jobs
    size: Size,

    /// Additional options related to the Slurm scheduler.
    slurm_configuration: ?ClusterSlurmConfigurationRequest = null,

    /// 1 or more tags added to the resource. Each tag consists of a tag key and tag
    /// value. The tag value is optional and can be an empty string.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .cluster_name = "clusterName",
        .networking = "networking",
        .scheduler = "scheduler",
        .size = "size",
        .slurm_configuration = "slurmConfiguration",
        .tags = "tags",
    };
};

pub const CreateClusterOutput = struct {
    /// The cluster resource.
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "cluster",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateClusterInput, options: CallOptions) !CreateClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "pcs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pcs", "PCS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSParallelComputingService.CreateCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateClusterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateClusterOutput, body, allocator);
}
