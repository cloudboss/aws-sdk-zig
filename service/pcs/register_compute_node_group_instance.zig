const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Endpoint = @import("endpoint.zig").Endpoint;
const NodeLifecycleActions = @import("node_lifecycle_actions.zig").NodeLifecycleActions;

pub const RegisterComputeNodeGroupInstanceInput = struct {
    /// The client-generated token to allow for retries.
    bootstrap_id: []const u8,

    /// The name or ID of the cluster to register the compute node group instance
    /// in.
    cluster_identifier: []const u8,

    pub const json_field_names = .{
        .bootstrap_id = "bootstrapId",
        .cluster_identifier = "clusterIdentifier",
    };
};

pub const RegisterComputeNodeGroupInstanceOutput = struct {
    /// The name of the cluster that the compute node registered into.
    cluster_name: ?[]const u8 = null,

    /// The ID of the compute node group that the compute node registered into.
    compute_node_group_id: ?[]const u8 = null,

    /// The name of the compute node group that the compute node registered into.
    compute_node_group_name: ?[]const u8 = null,

    /// The list of endpoints available for interaction with the scheduler.
    endpoints: ?[]const Endpoint = null,

    /// The scheduler node ID for this instance.
    node_id: []const u8,

    /// The node lifecycle actions configured for the node group, including scripts
    /// to run when a compute node finishes bootstrapping or becomes ready to accept
    /// jobs.
    node_lifecycle_actions: ?NodeLifecycleActions = null,

    /// For the Slurm scheduler, this is the shared Munge key the scheduler uses to
    /// authenticate compute node group instances.
    shared_secret: []const u8,

    pub const json_field_names = .{
        .cluster_name = "clusterName",
        .compute_node_group_id = "computeNodeGroupId",
        .compute_node_group_name = "computeNodeGroupName",
        .endpoints = "endpoints",
        .node_id = "nodeID",
        .node_lifecycle_actions = "nodeLifecycleActions",
        .shared_secret = "sharedSecret",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterComputeNodeGroupInstanceInput, options: CallOptions) !RegisterComputeNodeGroupInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterComputeNodeGroupInstanceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSParallelComputingService.RegisterComputeNodeGroupInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterComputeNodeGroupInstanceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(RegisterComputeNodeGroupInstanceOutput, body, allocator);
}
