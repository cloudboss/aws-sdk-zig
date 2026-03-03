const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ClusterAutoScalingConfigOutput = @import("cluster_auto_scaling_config_output.zig").ClusterAutoScalingConfigOutput;
const ClusterStatus = @import("cluster_status.zig").ClusterStatus;
const ClusterInstanceGroupDetails = @import("cluster_instance_group_details.zig").ClusterInstanceGroupDetails;
const ClusterNodeProvisioningMode = @import("cluster_node_provisioning_mode.zig").ClusterNodeProvisioningMode;
const ClusterNodeRecovery = @import("cluster_node_recovery.zig").ClusterNodeRecovery;
const ClusterOrchestrator = @import("cluster_orchestrator.zig").ClusterOrchestrator;
const ClusterRestrictedInstanceGroupDetails = @import("cluster_restricted_instance_group_details.zig").ClusterRestrictedInstanceGroupDetails;
const ClusterTieredStorageConfig = @import("cluster_tiered_storage_config.zig").ClusterTieredStorageConfig;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

pub const DescribeClusterInput = struct {
    /// The string name or the Amazon Resource Name (ARN) of the SageMaker HyperPod
    /// cluster.
    cluster_name: []const u8,

    pub const json_field_names = .{
        .cluster_name = "ClusterName",
    };
};

pub const DescribeClusterOutput = struct {
    /// The current autoscaling configuration and status for the autoscaler.
    auto_scaling: ?ClusterAutoScalingConfigOutput = null,

    /// The Amazon Resource Name (ARN) of the SageMaker HyperPod cluster.
    cluster_arn: []const u8,

    /// The name of the SageMaker HyperPod cluster.
    cluster_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that HyperPod uses for
    /// cluster autoscaling operations.
    cluster_role: ?[]const u8 = null,

    /// The status of the SageMaker HyperPod cluster.
    cluster_status: ClusterStatus,

    /// The time when the SageMaker Cluster is created.
    creation_time: ?i64 = null,

    /// The failure message of the SageMaker HyperPod cluster.
    failure_message: ?[]const u8 = null,

    /// The instance groups of the SageMaker HyperPod cluster.
    instance_groups: ?[]const ClusterInstanceGroupDetails = null,

    /// The mode used for provisioning nodes in the cluster.
    node_provisioning_mode: ?ClusterNodeProvisioningMode = null,

    /// The node recovery mode configured for the SageMaker HyperPod cluster.
    node_recovery: ?ClusterNodeRecovery = null,

    /// The type of orchestrator used for the SageMaker HyperPod cluster.
    orchestrator: ?ClusterOrchestrator = null,

    /// The specialized instance groups for training models like Amazon Nova to be
    /// created in the SageMaker HyperPod cluster.
    restricted_instance_groups: ?[]const ClusterRestrictedInstanceGroupDetails = null,

    /// The current configuration for managed tier checkpointing on the HyperPod
    /// cluster. For example, this shows whether the feature is enabled and the
    /// percentage of cluster memory allocated for checkpoint storage.
    tiered_storage_config: ?ClusterTieredStorageConfig = null,

    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .auto_scaling = "AutoScaling",
        .cluster_arn = "ClusterArn",
        .cluster_name = "ClusterName",
        .cluster_role = "ClusterRole",
        .cluster_status = "ClusterStatus",
        .creation_time = "CreationTime",
        .failure_message = "FailureMessage",
        .instance_groups = "InstanceGroups",
        .node_provisioning_mode = "NodeProvisioningMode",
        .node_recovery = "NodeRecovery",
        .orchestrator = "Orchestrator",
        .restricted_instance_groups = "RestrictedInstanceGroups",
        .tiered_storage_config = "TieredStorageConfig",
        .vpc_config = "VpcConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeClusterInput, options: CallOptions) !DescribeClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeClusterOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeClusterOutput, body, allocator);
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
