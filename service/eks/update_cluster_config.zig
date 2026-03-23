const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const UpdateAccessConfigRequest = @import("update_access_config_request.zig").UpdateAccessConfigRequest;
const ComputeConfigRequest = @import("compute_config_request.zig").ComputeConfigRequest;
const ControlPlaneScalingConfig = @import("control_plane_scaling_config.zig").ControlPlaneScalingConfig;
const KubernetesNetworkConfigRequest = @import("kubernetes_network_config_request.zig").KubernetesNetworkConfigRequest;
const Logging = @import("logging.zig").Logging;
const RemoteNetworkConfigRequest = @import("remote_network_config_request.zig").RemoteNetworkConfigRequest;
const VpcConfigRequest = @import("vpc_config_request.zig").VpcConfigRequest;
const StorageConfigRequest = @import("storage_config_request.zig").StorageConfigRequest;
const UpgradePolicyRequest = @import("upgrade_policy_request.zig").UpgradePolicyRequest;
const ZonalShiftConfigRequest = @import("zonal_shift_config_request.zig").ZonalShiftConfigRequest;
const Update = @import("update.zig").Update;

pub const UpdateClusterConfigInput = struct {
    /// The access configuration for the cluster.
    access_config: ?UpdateAccessConfigRequest = null,

    /// A unique, case-sensitive identifier that you provide to ensure
    /// the idempotency of the request.
    client_request_token: ?[]const u8 = null,

    /// Update the configuration of the compute capability of your EKS Auto Mode
    /// cluster. For
    /// example, enable the capability.
    compute_config: ?ComputeConfigRequest = null,

    /// The control plane scaling tier configuration. For more information, see EKS
    /// Provisioned Control Plane in the Amazon EKS User Guide.
    control_plane_scaling_config: ?ControlPlaneScalingConfig = null,

    /// Specifies whether to enable or disable deletion protection for the cluster.
    /// When
    /// enabled (`true`), the cluster cannot be deleted until deletion protection is
    /// explicitly disabled. When disabled (`false`), the cluster can be deleted
    /// normally.
    deletion_protection: ?bool = null,

    kubernetes_network_config: ?KubernetesNetworkConfigRequest = null,

    /// Enable or disable exporting the Kubernetes control plane logs for your
    /// cluster to CloudWatch Logs .
    /// By default, cluster control plane logs aren't exported to CloudWatch Logs .
    /// For more information,
    /// see [Amazon EKS
    /// cluster control plane
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

    /// The name of the Amazon EKS cluster to update.
    name: []const u8,

    remote_network_config: ?RemoteNetworkConfigRequest = null,

    resources_vpc_config: ?VpcConfigRequest = null,

    /// Update the configuration of the block storage capability of your EKS Auto
    /// Mode
    /// cluster. For example, enable the capability.
    storage_config: ?StorageConfigRequest = null,

    /// You can enable or disable extended support for clusters currently on
    /// standard support.
    /// You cannot disable extended support once it starts. You must enable extended
    /// support
    /// before your cluster exits standard support.
    upgrade_policy: ?UpgradePolicyRequest = null,

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
    /// You can start a zonal shift for an EKS cluster, or you can allow Amazon Web
    /// Services to do it for
    /// you by enabling *zonal autoshift*. This shift updates the flow of
    /// east-to-west network traffic in your cluster to only consider network
    /// endpoints for Pods
    /// running on worker nodes in healthy AZs. Additionally, any ALB or NLB
    /// handling ingress
    /// traffic for applications in your EKS cluster will automatically route
    /// traffic to targets
    /// in the healthy AZs. For more information about zonal shift in EKS, see
    /// [Learn about
    /// Amazon Application Recovery Controller (ARC) Zonal Shift in Amazon
    /// EKS](https://docs.aws.amazon.com/eks/latest/userguide/zone-shift.html) in
    /// the
    /// *
    /// Amazon EKS User Guide*
    /// .
    zonal_shift_config: ?ZonalShiftConfigRequest = null,

    pub const json_field_names = .{
        .access_config = "accessConfig",
        .client_request_token = "clientRequestToken",
        .compute_config = "computeConfig",
        .control_plane_scaling_config = "controlPlaneScalingConfig",
        .deletion_protection = "deletionProtection",
        .kubernetes_network_config = "kubernetesNetworkConfig",
        .logging = "logging",
        .name = "name",
        .remote_network_config = "remoteNetworkConfig",
        .resources_vpc_config = "resourcesVpcConfig",
        .storage_config = "storageConfig",
        .upgrade_policy = "upgradePolicy",
        .zonal_shift_config = "zonalShiftConfig",
    };
};

pub const UpdateClusterConfigOutput = struct {
    update: ?Update = null,

    pub const json_field_names = .{
        .update = "update",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateClusterConfigInput, options: CallOptions) !UpdateClusterConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "eks");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateClusterConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/update-config");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.access_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accessConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.compute_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"computeConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.control_plane_scaling_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"controlPlaneScalingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.deletion_protection) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deletionProtection\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kubernetes_network_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kubernetesNetworkConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.logging) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"logging\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.remote_network_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"remoteNetworkConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resources_vpc_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourcesVpcConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.storage_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"storageConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.upgrade_policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"upgradePolicy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.zonal_shift_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"zonalShiftConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateClusterConfigOutput {
    var result: UpdateClusterConfigOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateClusterConfigOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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
