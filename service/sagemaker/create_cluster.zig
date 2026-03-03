const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ClusterAutoScalingConfig = @import("cluster_auto_scaling_config.zig").ClusterAutoScalingConfig;
const ClusterInstanceGroupSpecification = @import("cluster_instance_group_specification.zig").ClusterInstanceGroupSpecification;
const ClusterNodeProvisioningMode = @import("cluster_node_provisioning_mode.zig").ClusterNodeProvisioningMode;
const ClusterNodeRecovery = @import("cluster_node_recovery.zig").ClusterNodeRecovery;
const ClusterOrchestrator = @import("cluster_orchestrator.zig").ClusterOrchestrator;
const ClusterRestrictedInstanceGroupSpecification = @import("cluster_restricted_instance_group_specification.zig").ClusterRestrictedInstanceGroupSpecification;
const Tag = @import("tag.zig").Tag;
const ClusterTieredStorageConfig = @import("cluster_tiered_storage_config.zig").ClusterTieredStorageConfig;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

pub const CreateClusterInput = struct {
    /// The autoscaling configuration for the cluster. Enables automatic scaling of
    /// cluster nodes based on workload demand using a Karpenter-based system.
    auto_scaling: ?ClusterAutoScalingConfig = null,

    /// The name for the new SageMaker HyperPod cluster.
    cluster_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role that HyperPod assumes to
    /// perform cluster autoscaling operations. This role must have permissions for
    /// `sagemaker:BatchAddClusterNodes` and `sagemaker:BatchDeleteClusterNodes`.
    /// This is only required when autoscaling is enabled and when HyperPod is
    /// performing autoscaling operations.
    cluster_role: ?[]const u8 = null,

    /// The instance groups to be created in the SageMaker HyperPod cluster.
    instance_groups: ?[]const ClusterInstanceGroupSpecification = null,

    /// The mode for provisioning nodes in the cluster. You can specify the
    /// following modes:
    ///
    /// * **Continuous**: Scaling behavior that enables 1) concurrent operation
    ///   execution within instance groups, 2) continuous retry mechanisms for
    ///   failed operations, 3) enhanced customer visibility into cluster events
    ///   through detailed event streams, 4) partial provisioning capabilities. Your
    ///   clusters and instance groups remain `InService` while scaling. This mode
    ///   is only supported for EKS orchestrated clusters.
    node_provisioning_mode: ?ClusterNodeProvisioningMode = null,

    /// The node recovery mode for the SageMaker HyperPod cluster. When set to
    /// `Automatic`, SageMaker HyperPod will automatically reboot or replace faulty
    /// nodes when issues are detected. When set to `None`, cluster administrators
    /// will need to manually manage any faulty cluster instances.
    node_recovery: ?ClusterNodeRecovery = null,

    /// The type of orchestrator to use for the SageMaker HyperPod cluster.
    /// Currently, the only supported value is `"eks"`, which is to use an Amazon
    /// Elastic Kubernetes Service cluster as the orchestrator.
    orchestrator: ?ClusterOrchestrator = null,

    /// The specialized instance groups for training models like Amazon Nova to be
    /// created in the SageMaker HyperPod cluster.
    restricted_instance_groups: ?[]const ClusterRestrictedInstanceGroupSpecification = null,

    /// Custom tags for managing the SageMaker HyperPod cluster as an Amazon Web
    /// Services resource. You can add tags to your cluster in the same way you add
    /// them in other Amazon Web Services services that support tagging. To learn
    /// more about tagging Amazon Web Services resources in general, see [Tagging
    /// Amazon Web Services Resources User
    /// Guide](https://docs.aws.amazon.com/tag-editor/latest/userguide/tagging.html).
    tags: ?[]const Tag = null,

    /// The configuration for managed tier checkpointing on the HyperPod cluster.
    /// When enabled, this feature uses a multi-tier storage approach for storing
    /// model checkpoints, providing faster checkpoint operations and improved fault
    /// tolerance across cluster nodes.
    tiered_storage_config: ?ClusterTieredStorageConfig = null,

    /// Specifies the Amazon Virtual Private Cloud (VPC) that is associated with the
    /// Amazon SageMaker HyperPod cluster. You can control access to and from your
    /// resources by configuring your VPC. For more information, see [Give SageMaker
    /// access to resources in your Amazon
    /// VPC](https://docs.aws.amazon.com/sagemaker/latest/dg/infrastructure-give-access.html).
    ///
    /// When your Amazon VPC and subnets support IPv6, network communications differ
    /// based on the cluster orchestration platform:
    ///
    /// * Slurm-orchestrated clusters automatically configure nodes with dual IPv6
    ///   and IPv4 addresses, allowing immediate IPv6 network communications.
    /// * In Amazon EKS-orchestrated clusters, nodes receive dual-stack addressing,
    ///   but pods can only use IPv6 when the Amazon EKS cluster is explicitly
    ///   IPv6-enabled. For information about deploying an IPv6 Amazon EKS cluster,
    ///   see [Amazon EKS IPv6 Cluster
    ///   Deployment](https://docs.aws.amazon.com/eks/latest/userguide/deploy-ipv6-cluster.html#_deploy_an_ipv6_cluster_with_eksctl).
    ///
    /// Additional resources for IPv6 configuration:
    ///
    /// * For information about adding IPv6 support to your VPC, see to [IPv6
    ///   Support for
    ///   VPC](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-migrate-ipv6.html).
    /// * For information about creating a new IPv6-compatible VPC, see [Amazon VPC
    ///   Creation
    ///   Guide](https://docs.aws.amazon.com/vpc/latest/userguide/create-vpc.html).
    /// * To configure SageMaker HyperPod with a custom Amazon VPC, see [Custom
    ///   Amazon VPC Setup for SageMaker
    ///   HyperPod](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-hyperpod-prerequisites.html#sagemaker-hyperpod-prerequisites-optional-vpc).
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .auto_scaling = "AutoScaling",
        .cluster_name = "ClusterName",
        .cluster_role = "ClusterRole",
        .instance_groups = "InstanceGroups",
        .node_provisioning_mode = "NodeProvisioningMode",
        .node_recovery = "NodeRecovery",
        .orchestrator = "Orchestrator",
        .restricted_instance_groups = "RestrictedInstanceGroups",
        .tags = "Tags",
        .tiered_storage_config = "TieredStorageConfig",
        .vpc_config = "VpcConfig",
    };
};

pub const CreateClusterOutput = struct {
    /// The Amazon Resource Name (ARN) of the cluster.
    cluster_arn: []const u8,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateClusterInput, options: CallOptions) !CreateClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateClusterInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateClusterOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateClusterOutput, body, allocator);
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
