const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchDeleteClusterNodesError = @import("batch_delete_cluster_nodes_error.zig").BatchDeleteClusterNodesError;
const BatchDeleteClusterNodeLogicalIdsError = @import("batch_delete_cluster_node_logical_ids_error.zig").BatchDeleteClusterNodeLogicalIdsError;

pub const BatchDeleteClusterNodesInput = struct {
    /// The name of the SageMaker HyperPod cluster from which to delete the
    /// specified nodes.
    cluster_name: []const u8,

    /// A list of node IDs to be deleted from the specified cluster.
    ///
    /// * For SageMaker HyperPod clusters using the Slurm workload manager, you
    ///   cannot remove instances that are configured as Slurm controller nodes.
    /// * If you need to delete more than 99 instances, contact
    ///   [Support](http://aws.amazon.com/contact-us/) for assistance.
    node_ids: ?[]const []const u8 = null,

    /// A list of `NodeLogicalIds` identifying the nodes to be deleted. You can
    /// specify up to 50 `NodeLogicalIds`. You must specify either `NodeLogicalIds`,
    /// `InstanceIds`, or both, with a combined maximum of 50 identifiers.
    node_logical_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .cluster_name = "ClusterName",
        .node_ids = "NodeIds",
        .node_logical_ids = "NodeLogicalIds",
    };
};

pub const BatchDeleteClusterNodesOutput = struct {
    /// A list of errors encountered when deleting the specified nodes.
    failed: ?[]const BatchDeleteClusterNodesError = null,

    /// A list of `NodeLogicalIds` that could not be deleted, along with error
    /// information explaining why the deletion failed.
    failed_node_logical_ids: ?[]const BatchDeleteClusterNodeLogicalIdsError = null,

    /// A list of node IDs that were successfully deleted from the specified
    /// cluster.
    successful: ?[]const []const u8 = null,

    /// A list of `NodeLogicalIds` that were successfully deleted from the cluster.
    successful_node_logical_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .failed = "Failed",
        .failed_node_logical_ids = "FailedNodeLogicalIds",
        .successful = "Successful",
        .successful_node_logical_ids = "SuccessfulNodeLogicalIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDeleteClusterNodesInput, options: CallOptions) !BatchDeleteClusterNodesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDeleteClusterNodesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.BatchDeleteClusterNodes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDeleteClusterNodesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchDeleteClusterNodesOutput, body, allocator);
}
