const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComputeNodeGroupConfiguration = @import("compute_node_group_configuration.zig").ComputeNodeGroupConfiguration;
const QueueSlurmConfigurationRequest = @import("queue_slurm_configuration_request.zig").QueueSlurmConfigurationRequest;
const Queue = @import("queue.zig").Queue;

pub const CreateQueueInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. Idempotency ensures that an API request
    /// completes only once. With an idempotent request, if the original request
    /// completes successfully, the subsequent retries with the same client token
    /// return the result from the original successful request and they have no
    /// additional effect. If you don't specify a client token, the CLI and SDK
    /// automatically generate 1 for you.
    client_token: ?[]const u8 = null,

    /// The name or ID of the cluster for which to create a queue.
    cluster_identifier: []const u8,

    /// The list of compute node group configurations to associate with the queue.
    /// Queues assign jobs to associated compute node groups.
    compute_node_group_configurations: ?[]const ComputeNodeGroupConfiguration = null,

    /// A name to identify the queue.
    queue_name: []const u8,

    /// Additional options related to the Slurm scheduler.
    slurm_configuration: ?QueueSlurmConfigurationRequest = null,

    /// 1 or more tags added to the resource. Each tag consists of a tag key and tag
    /// value. The tag value is optional and can be an empty string.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .cluster_identifier = "clusterIdentifier",
        .compute_node_group_configurations = "computeNodeGroupConfigurations",
        .queue_name = "queueName",
        .slurm_configuration = "slurmConfiguration",
        .tags = "tags",
    };
};

pub const CreateQueueOutput = struct {
    queue: ?Queue = null,

    pub const json_field_names = .{
        .queue = "queue",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateQueueInput, options: CallOptions) !CreateQueueOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateQueueInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSParallelComputingService.CreateQueue");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateQueueOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateQueueOutput, body, allocator);
}
