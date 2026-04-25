const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AMITypes = @import("ami_types.zig").AMITypes;
const CapacityTypes = @import("capacity_types.zig").CapacityTypes;
const LaunchTemplateSpecification = @import("launch_template_specification.zig").LaunchTemplateSpecification;
const NodeRepairConfig = @import("node_repair_config.zig").NodeRepairConfig;
const RemoteAccessConfig = @import("remote_access_config.zig").RemoteAccessConfig;
const NodegroupScalingConfig = @import("nodegroup_scaling_config.zig").NodegroupScalingConfig;
const Taint = @import("taint.zig").Taint;
const NodegroupUpdateConfig = @import("nodegroup_update_config.zig").NodegroupUpdateConfig;
const WarmPoolConfig = @import("warm_pool_config.zig").WarmPoolConfig;
const Nodegroup = @import("nodegroup.zig").Nodegroup;

pub const CreateNodegroupInput = struct {
    /// The AMI type for your node group. If you specify `launchTemplate`, and your
    /// launch template uses a custom AMI,
    /// then don't specify `amiType`, or the node group deployment
    /// will fail. If your launch template uses a Windows custom AMI, then add
    /// `eks:kube-proxy-windows` to your Windows nodes `rolearn` in
    /// the `aws-auth`
    /// `ConfigMap`. For more information about using launch templates with Amazon
    /// EKS, see [Customizing managed nodes with launch
    /// templates](https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html) in the *Amazon EKS User Guide*.
    ami_type: ?AMITypes = null,

    /// The capacity type for your node group.
    capacity_type: ?CapacityTypes = null,

    /// A unique, case-sensitive identifier that you provide to ensure
    /// the idempotency of the request.
    client_request_token: ?[]const u8 = null,

    /// The name of your cluster.
    cluster_name: []const u8,

    /// The root device disk size (in GiB) for your node group instances. The
    /// default disk
    /// size is 20 GiB for Linux and Bottlerocket. The default disk size is 50 GiB
    /// for Windows.
    /// If you specify `launchTemplate`, then don't specify `diskSize`, or the node
    /// group
    /// deployment will fail. For more information about using launch templates with
    /// Amazon EKS, see [Customizing managed nodes with launch
    /// templates](https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html) in the *Amazon EKS User Guide*.
    disk_size: ?i32 = null,

    /// Specify the instance types for a node group. If you specify a GPU instance
    /// type, make
    /// sure to also specify an applicable GPU AMI type with the `amiType`
    /// parameter.
    /// If you specify `launchTemplate`, then you can specify zero or one instance
    /// type in your launch template *or* you can specify 0-20 instance types
    /// for `instanceTypes`. If however, you specify an instance type in your launch
    /// template *and* specify any `instanceTypes`, the node group
    /// deployment will fail. If you don't specify an instance type in a launch
    /// template or for
    /// `instanceTypes`, then `t3.medium` is used, by default. If you
    /// specify `Spot` for `capacityType`, then we recommend specifying
    /// multiple values for `instanceTypes`. For more information, see [Managed node
    /// group capacity
    /// types](https://docs.aws.amazon.com/eks/latest/userguide/managed-node-groups.html#managed-node-group-capacity-types) and [Customizing managed nodes with
    /// launch
    /// templates](https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html) in the *Amazon EKS User Guide*.
    instance_types: ?[]const []const u8 = null,

    /// The Kubernetes `labels` to apply to the nodes in the node group when they
    /// are
    /// created.
    labels: ?[]const aws.map.StringMapEntry = null,

    /// An object representing a node group's launch template specification. When
    /// using this
    /// object, don't directly specify `instanceTypes`, `diskSize`, or
    /// `remoteAccess`. You cannot later specify a different launch template ID
    /// or name than what was used to create the node group.
    ///
    /// Make sure that the launch template meets the requirements in
    /// `launchTemplateSpecification`. Also refer to [Customizing managed nodes with
    /// launch
    /// templates](https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html) in the *Amazon EKS User Guide*.
    launch_template: ?LaunchTemplateSpecification = null,

    /// The unique name to give your node group.
    nodegroup_name: []const u8,

    /// The node auto repair configuration for the node group.
    node_repair_config: ?NodeRepairConfig = null,

    /// The Amazon Resource Name (ARN) of the IAM role to associate with your node
    /// group. The Amazon EKS worker
    /// node `kubelet` daemon makes calls to Amazon Web Services APIs on your
    /// behalf. Nodes receive
    /// permissions for these API calls through an IAM instance profile and
    /// associated
    /// policies. Before you can launch nodes and register them into a cluster, you
    /// must create
    /// an IAM role for those nodes to use when they are launched. For more
    /// information, see
    /// [Amazon EKS
    /// node IAM
    /// role](https://docs.aws.amazon.com/eks/latest/userguide/create-node-role.html) in the *
    /// Amazon EKS User Guide*
    /// .
    /// If you specify `launchTemplate`, then don't specify `
    /// [IamInstanceProfile](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_IamInstanceProfile.html)
    /// ` in your launch template, or the node group
    /// deployment will fail. For more information about using launch templates with
    /// Amazon EKS, see [Customizing managed nodes with launch
    /// templates](https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html) in the *Amazon EKS User Guide*.
    node_role: []const u8,

    /// The AMI version of the Amazon EKS optimized AMI to use with your node group.
    /// By default,
    /// the latest available AMI version for the node group's current Kubernetes
    /// version is used. For
    /// information about Linux versions, see [Amazon EKS
    /// optimized Amazon Linux AMI
    /// versions](https://docs.aws.amazon.com/eks/latest/userguide/eks-linux-ami-versions.html) in the *Amazon EKS User Guide*. Amazon EKS managed node
    /// groups support the November 2022 and later releases of the Windows AMIs. For
    /// information
    /// about Windows versions, see [Amazon EKS
    /// optimized Windows AMI
    /// versions](https://docs.aws.amazon.com/eks/latest/userguide/eks-ami-versions-windows.html) in the *Amazon EKS User Guide*.
    ///
    /// If you specify `launchTemplate`, and your launch template uses a custom AMI,
    /// then don't specify
    /// `releaseVersion`, or the node group deployment will fail.
    /// For more information about using launch templates with Amazon EKS, see
    /// [Customizing managed nodes with launch
    /// templates](https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html) in the *Amazon EKS User Guide*.
    release_version: ?[]const u8 = null,

    /// The remote access configuration to use with your node group. For Linux, the
    /// protocol
    /// is SSH. For Windows, the protocol is RDP. If you specify `launchTemplate`,
    /// then don't specify
    /// `remoteAccess`, or the node group deployment will fail.
    /// For more information about using launch templates with Amazon EKS, see
    /// [Customizing managed nodes with launch
    /// templates](https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html) in the *Amazon EKS User Guide*.
    remote_access: ?RemoteAccessConfig = null,

    /// The scaling configuration details for the Auto Scaling group that is created
    /// for your
    /// node group.
    scaling_config: ?NodegroupScalingConfig = null,

    /// The subnets to use for the Auto Scaling group that is created for your node
    /// group.
    /// If you specify `launchTemplate`, then don't specify `
    /// [SubnetId](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateNetworkInterface.html)
    /// ` in your launch template, or the node group deployment
    /// will fail. For more information about using launch templates with Amazon
    /// EKS, see [Customizing managed nodes with launch
    /// templates](https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html) in the *Amazon EKS User Guide*.
    subnets: []const []const u8,

    /// Metadata that assists with categorization and organization.
    /// Each tag consists of a key and an optional value. You define both. Tags
    /// don't
    /// propagate to any other cluster or Amazon Web Services resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The Kubernetes taints to be applied to the nodes in the node group. For more
    /// information,
    /// see [Node taints on
    /// managed node
    /// groups](https://docs.aws.amazon.com/eks/latest/userguide/node-taints-managed-node-groups.html).
    taints: ?[]const Taint = null,

    /// The node group update configuration.
    update_config: ?NodegroupUpdateConfig = null,

    /// The Kubernetes version to use for your managed nodes. By default, the
    /// Kubernetes version of the
    /// cluster is used, and this is the only accepted specified value. If you
    /// specify `launchTemplate`,
    /// and your launch template uses a custom AMI, then don't specify `version`, or
    /// the node group
    /// deployment will fail. For more information about using launch templates with
    /// Amazon EKS, see [Customizing managed nodes with launch
    /// templates](https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html) in the *Amazon EKS User Guide*.
    version: ?[]const u8 = null,

    /// The warm pool configuration for the node group. Warm pools maintain
    /// pre-initialized EC2 instances that can quickly join your cluster during
    /// scale-out events, improving application scaling performance and reducing
    /// costs.
    warm_pool_config: ?WarmPoolConfig = null,

    pub const json_field_names = .{
        .ami_type = "amiType",
        .capacity_type = "capacityType",
        .client_request_token = "clientRequestToken",
        .cluster_name = "clusterName",
        .disk_size = "diskSize",
        .instance_types = "instanceTypes",
        .labels = "labels",
        .launch_template = "launchTemplate",
        .nodegroup_name = "nodegroupName",
        .node_repair_config = "nodeRepairConfig",
        .node_role = "nodeRole",
        .release_version = "releaseVersion",
        .remote_access = "remoteAccess",
        .scaling_config = "scalingConfig",
        .subnets = "subnets",
        .tags = "tags",
        .taints = "taints",
        .update_config = "updateConfig",
        .version = "version",
        .warm_pool_config = "warmPoolConfig",
    };
};

pub const CreateNodegroupOutput = struct {
    /// The full description of your new node group.
    nodegroup: ?Nodegroup = null,

    pub const json_field_names = .{
        .nodegroup = "nodegroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNodegroupInput, options: CallOptions) !CreateNodegroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNodegroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/node-groups");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.ami_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"amiType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.capacity_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"capacityType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.disk_size) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"diskSize\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.instance_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"instanceTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.labels) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"labels\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.launch_template) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"launchTemplate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"nodegroupName\":");
    try aws.json.writeValue(@TypeOf(input.nodegroup_name), input.nodegroup_name, allocator, &body_buf);
    has_prev = true;
    if (input.node_repair_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nodeRepairConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"nodeRole\":");
    try aws.json.writeValue(@TypeOf(input.node_role), input.node_role, allocator, &body_buf);
    has_prev = true;
    if (input.release_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"releaseVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.remote_access) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"remoteAccess\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.scaling_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"scalingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"subnets\":");
    try aws.json.writeValue(@TypeOf(input.subnets), input.subnets, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.taints) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"taints\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.update_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"updateConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"version\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.warm_pool_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"warmPoolConfig\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNodegroupOutput {
    var result: CreateNodegroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateNodegroupOutput, body, allocator);
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
