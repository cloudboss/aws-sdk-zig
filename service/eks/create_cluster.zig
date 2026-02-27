const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CreateAccessConfigRequest = @import("create_access_config_request.zig").CreateAccessConfigRequest;
const ComputeConfigRequest = @import("compute_config_request.zig").ComputeConfigRequest;
const ControlPlaneScalingConfig = @import("control_plane_scaling_config.zig").ControlPlaneScalingConfig;
const EncryptionConfig = @import("encryption_config.zig").EncryptionConfig;
const KubernetesNetworkConfigRequest = @import("kubernetes_network_config_request.zig").KubernetesNetworkConfigRequest;
const Logging = @import("logging.zig").Logging;
const OutpostConfigRequest = @import("outpost_config_request.zig").OutpostConfigRequest;
const RemoteNetworkConfigRequest = @import("remote_network_config_request.zig").RemoteNetworkConfigRequest;
const VpcConfigRequest = @import("vpc_config_request.zig").VpcConfigRequest;
const StorageConfigRequest = @import("storage_config_request.zig").StorageConfigRequest;
const UpgradePolicyRequest = @import("upgrade_policy_request.zig").UpgradePolicyRequest;
const ZonalShiftConfigRequest = @import("zonal_shift_config_request.zig").ZonalShiftConfigRequest;
const Cluster = @import("cluster.zig").Cluster;

pub const CreateClusterInput = struct {
    /// The access configuration for the cluster.
    access_config: ?CreateAccessConfigRequest = null,

    /// If you set this value to `False` when creating a cluster, the default
    /// networking add-ons will not be installed.
    ///
    /// The default networking add-ons include `vpc-cni`, `coredns`, and
    /// `kube-proxy`.
    ///
    /// Use this option when you plan to install third-party alternative add-ons or
    /// self-manage the default networking add-ons.
    bootstrap_self_managed_addons: ?bool = null,

    /// A unique, case-sensitive identifier that you provide to ensure
    /// the idempotency of the request.
    client_request_token: ?[]const u8 = null,

    /// Enable or disable the compute capability of EKS Auto Mode when creating your
    /// EKS Auto
    /// Mode cluster. If the compute capability is enabled, EKS Auto Mode will
    /// create and delete
    /// EC2 Managed Instances in your Amazon Web Services account
    compute_config: ?ComputeConfigRequest = null,

    /// The control plane scaling tier configuration. For more information, see EKS
    /// Provisioned Control Plane in the Amazon EKS User Guide.
    control_plane_scaling_config: ?ControlPlaneScalingConfig = null,

    /// Indicates whether to enable deletion protection for the cluster. When
    /// enabled, the cluster
    /// cannot be deleted unless deletion protection is first disabled. This helps
    /// prevent
    /// accidental cluster deletion. Default value is `false`.
    deletion_protection: ?bool = null,

    /// The encryption configuration for the cluster.
    encryption_config: ?[]const EncryptionConfig = null,

    /// The Kubernetes network configuration for the cluster.
    kubernetes_network_config: ?KubernetesNetworkConfigRequest = null,

    /// Enable or disable exporting the Kubernetes control plane logs for your
    /// cluster to CloudWatch Logs .
    /// By default, cluster control plane logs aren't exported to CloudWatch Logs .
    /// For more information,
    /// see [Amazon EKS
    /// Cluster control plane
    /// logs](https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html) in the
    /// *
    /// Amazon EKS User Guide*
    /// .
    ///
    /// CloudWatch Logs ingestion, archive storage, and data scanning rates apply to
    /// exported
    /// control plane logs. For more information, see [CloudWatch
    /// Pricing](http://aws.amazon.com/cloudwatch/pricing/).
    logging: ?Logging = null,

    /// The unique name to give to your cluster. The name can contain only
    /// alphanumeric characters (case-sensitive),
    /// hyphens, and underscores. It must start with an alphanumeric character and
    /// can't be longer than
    /// 100 characters. The name must be unique within the Amazon Web Services
    /// Region and Amazon Web Services account that you're
    /// creating the cluster in.
    name: []const u8,

    /// An object representing the configuration of your local Amazon EKS cluster on
    /// an Amazon Web Services
    /// Outpost. Before creating a local cluster on an Outpost, review [Local
    /// clusters
    /// for Amazon EKS on Amazon Web Services
    /// Outposts](https://docs.aws.amazon.com/eks/latest/userguide/eks-outposts-local-cluster-overview.html) in the *Amazon EKS User Guide*. This object isn't
    /// available for creating Amazon EKS clusters on the Amazon Web Services cloud.
    outpost_config: ?OutpostConfigRequest = null,

    /// The configuration in the cluster for EKS Hybrid Nodes. You can add, change,
    /// or remove this
    /// configuration after the cluster is created.
    remote_network_config: ?RemoteNetworkConfigRequest = null,

    /// The VPC configuration that's used by the cluster control plane. Amazon EKS
    /// VPC resources
    /// have specific requirements to work properly with Kubernetes. For more
    /// information, see [Cluster VPC
    /// Considerations](https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html) and [Cluster Security Group Considerations](https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html) in the
    /// *Amazon EKS User Guide*. You must specify at least two subnets. You can
    /// specify up to five
    /// security groups. However, we recommend that you use a dedicated security
    /// group for your
    /// cluster control plane.
    resources_vpc_config: VpcConfigRequest,

    /// The Amazon Resource Name (ARN) of the IAM role that provides permissions for
    /// the Kubernetes control plane
    /// to make calls to Amazon Web Services API operations on your behalf. For more
    /// information, see [Amazon EKS Service
    /// IAM
    /// Role](https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html) in the *
    /// Amazon EKS User Guide*
    /// .
    role_arn: []const u8,

    /// Enable or disable the block storage capability of EKS Auto Mode when
    /// creating your EKS
    /// Auto Mode cluster. If the block storage capability is enabled, EKS Auto Mode
    /// will create
    /// and delete EBS volumes in your Amazon Web Services account.
    storage_config: ?StorageConfigRequest = null,

    /// Metadata that assists with categorization and organization.
    /// Each tag consists of a key and an optional value. You define both. Tags
    /// don't
    /// propagate to any other cluster or Amazon Web Services resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// New clusters, by default, have extended support enabled. You can disable
    /// extended
    /// support when creating a cluster by setting this value to `STANDARD`.
    upgrade_policy: ?UpgradePolicyRequest = null,

    /// The desired Kubernetes version for your cluster. If you don't specify a
    /// value here, the
    /// default version available in Amazon EKS is used.
    ///
    /// The default version might not be the latest version available.
    version: ?[]const u8 = null,

    /// Enable or disable ARC zonal shift for the cluster. If zonal shift is
    /// enabled, Amazon Web Services
    /// configures zonal autoshift for the cluster.
    ///
    /// Zonal shift is a feature of Amazon Application Recovery Controller (ARC).
    /// ARC zonal shift is designed to be a
    /// temporary measure that allows you to move traffic for a resource away from
    /// an impaired
    /// AZ until the zonal shift expires or you cancel it. You can extend the zonal
    /// shift if
    /// necessary.
    ///
    /// You can start a zonal shift for an Amazon EKS cluster, or you can allow
    /// Amazon Web Services to do it for
    /// you by enabling *zonal autoshift*. This shift updates the flow of
    /// east-to-west network traffic in your cluster to only consider network
    /// endpoints for Pods
    /// running on worker nodes in healthy AZs. Additionally, any ALB or NLB
    /// handling ingress
    /// traffic for applications in your Amazon EKS cluster will automatically route
    /// traffic to
    /// targets in the healthy AZs. For more information about zonal shift in EKS,
    /// see [Learn about
    /// Amazon Application Recovery Controller (ARC) Zonal Shift in Amazon
    /// EKS](https://docs.aws.amazon.com/eks/latest/userguide/zone-shift.html) in
    /// the
    /// *
    /// Amazon EKS User Guide*
    /// .
    zonal_shift_config: ?ZonalShiftConfigRequest = null,

    pub const json_field_names = .{
        .access_config = "accessConfig",
        .bootstrap_self_managed_addons = "bootstrapSelfManagedAddons",
        .client_request_token = "clientRequestToken",
        .compute_config = "computeConfig",
        .control_plane_scaling_config = "controlPlaneScalingConfig",
        .deletion_protection = "deletionProtection",
        .encryption_config = "encryptionConfig",
        .kubernetes_network_config = "kubernetesNetworkConfig",
        .logging = "logging",
        .name = "name",
        .outpost_config = "outpostConfig",
        .remote_network_config = "remoteNetworkConfig",
        .resources_vpc_config = "resourcesVpcConfig",
        .role_arn = "roleArn",
        .storage_config = "storageConfig",
        .tags = "tags",
        .upgrade_policy = "upgradePolicy",
        .version = "version",
        .zonal_shift_config = "zonalShiftConfig",
    };
};

pub const CreateClusterOutput = struct {
    /// The full description of your new cluster.
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "cluster",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateClusterInput, options: Options) !CreateClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "eks");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/clusters";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.access_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"accessConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.bootstrap_self_managed_addons) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"bootstrapSelfManagedAddons\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.compute_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"computeConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.control_plane_scaling_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"controlPlaneScalingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.deletion_protection) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"deletionProtection\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.encryption_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"encryptionConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.kubernetes_network_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"kubernetesNetworkConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.logging) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"logging\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, alloc, &body_buf);
    has_prev = true;
    if (input.outpost_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"outpostConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.remote_network_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"remoteNetworkConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"resourcesVpcConfig\":");
    try aws.json.writeValue(@TypeOf(input.resources_vpc_config), input.resources_vpc_config, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, alloc, &body_buf);
    has_prev = true;
    if (input.storage_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"storageConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.upgrade_policy) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"upgradePolicy\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.version) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"version\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.zonal_shift_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"zonalShiftConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateClusterOutput {
    var result: CreateClusterOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateClusterOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClientException")) {
        return .{ .arena = arena, .kind = .{ .client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourcePropagationDelayException")) {
        return .{ .arena = arena, .kind = .{ .resource_propagation_delay_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerException")) {
        return .{ .arena = arena, .kind = .{ .server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedAvailabilityZoneException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_availability_zone_exception = .{
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
