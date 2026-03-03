const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ClusterAutoScalingConfig = @import("cluster_auto_scaling_config.zig").ClusterAutoScalingConfig;
const ClusterInstanceGroupSpecification = @import("cluster_instance_group_specification.zig").ClusterInstanceGroupSpecification;
const ClusterNodeProvisioningMode = @import("cluster_node_provisioning_mode.zig").ClusterNodeProvisioningMode;
const ClusterNodeRecovery = @import("cluster_node_recovery.zig").ClusterNodeRecovery;
const ClusterRestrictedInstanceGroupSpecification = @import("cluster_restricted_instance_group_specification.zig").ClusterRestrictedInstanceGroupSpecification;
const ClusterTieredStorageConfig = @import("cluster_tiered_storage_config.zig").ClusterTieredStorageConfig;

pub const UpdateClusterInput = struct {
    /// Updates the autoscaling configuration for the cluster. Use to enable or
    /// disable automatic node scaling.
    auto_scaling: ?ClusterAutoScalingConfig = null,

    /// Specify the name of the SageMaker HyperPod cluster you want to update.
    cluster_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role that HyperPod assumes for
    /// cluster autoscaling operations. Cannot be updated while autoscaling is
    /// enabled.
    cluster_role: ?[]const u8 = null,

    /// Specify the instance groups to update.
    instance_groups: ?[]const ClusterInstanceGroupSpecification = null,

    /// Specify the names of the instance groups to delete. Use a single `,` as the
    /// separator between multiple names.
    instance_groups_to_delete: ?[]const []const u8 = null,

    /// Determines how instance provisioning is handled during cluster operations.
    /// In `Continuous` mode, the cluster provisions available instances
    /// incrementally and retries until the target count is reached. The cluster
    /// becomes operational once cluster-level resources are ready. Use
    /// `CurrentCount` and `TargetCount` in `DescribeCluster` to track provisioning
    /// progress.
    node_provisioning_mode: ?ClusterNodeProvisioningMode = null,

    /// The node recovery mode to be applied to the SageMaker HyperPod cluster.
    node_recovery: ?ClusterNodeRecovery = null,

    /// The specialized instance groups for training models like Amazon Nova to be
    /// created in the SageMaker HyperPod cluster.
    restricted_instance_groups: ?[]const ClusterRestrictedInstanceGroupSpecification = null,

    /// Updates the configuration for managed tier checkpointing on the HyperPod
    /// cluster. For example, you can enable or disable the feature and modify the
    /// percentage of cluster memory allocated for checkpoint storage.
    tiered_storage_config: ?ClusterTieredStorageConfig = null,

    pub const json_field_names = .{
        .auto_scaling = "AutoScaling",
        .cluster_name = "ClusterName",
        .cluster_role = "ClusterRole",
        .instance_groups = "InstanceGroups",
        .instance_groups_to_delete = "InstanceGroupsToDelete",
        .node_provisioning_mode = "NodeProvisioningMode",
        .node_recovery = "NodeRecovery",
        .restricted_instance_groups = "RestrictedInstanceGroups",
        .tiered_storage_config = "TieredStorageConfig",
    };
};

pub const UpdateClusterOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated SageMaker HyperPod cluster.
    cluster_arn: []const u8,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateClusterInput, options: Options) !UpdateClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateClusterInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateClusterOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateClusterOutput, body, allocator);
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
