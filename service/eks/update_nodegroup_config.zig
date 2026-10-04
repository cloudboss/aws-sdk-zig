const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateLabelsPayload = @import("update_labels_payload.zig").UpdateLabelsPayload;
const NodeRepairConfig = @import("node_repair_config.zig").NodeRepairConfig;
const NodegroupScalingConfig = @import("nodegroup_scaling_config.zig").NodegroupScalingConfig;
const UpdateTaintsPayload = @import("update_taints_payload.zig").UpdateTaintsPayload;
const NodegroupUpdateConfig = @import("nodegroup_update_config.zig").NodegroupUpdateConfig;
const WarmPoolConfig = @import("warm_pool_config.zig").WarmPoolConfig;
const Update = @import("update.zig").Update;

pub const UpdateNodegroupConfigInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure
    /// the idempotency of the request.
    client_request_token: ?[]const u8 = null,

    /// The name of your cluster.
    cluster_name: []const u8,

    /// The Kubernetes `labels` to apply to the nodes in the node group after the
    /// update.
    labels: ?UpdateLabelsPayload = null,

    /// The name of the managed node group to update.
    nodegroup_name: []const u8,

    /// The node auto repair configuration for the node group.
    node_repair_config: ?NodeRepairConfig = null,

    /// The scaling configuration details for the Auto Scaling group after the
    /// update.
    scaling_config: ?NodegroupScalingConfig = null,

    /// The Kubernetes taints to be applied to the nodes in the node group after the
    /// update. For
    /// more information, see [Node taints on
    /// managed node
    /// groups](https://docs.aws.amazon.com/eks/latest/userguide/node-taints-managed-node-groups.html).
    taints: ?UpdateTaintsPayload = null,

    /// The node group update configuration.
    update_config: ?NodegroupUpdateConfig = null,

    /// The warm pool configuration to apply to the node group. You can use this to
    /// add a warm pool to an existing node group or modify the settings of an
    /// existing warm pool.
    warm_pool_config: ?WarmPoolConfig = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .cluster_name = "clusterName",
        .labels = "labels",
        .nodegroup_name = "nodegroupName",
        .node_repair_config = "nodeRepairConfig",
        .scaling_config = "scalingConfig",
        .taints = "taints",
        .update_config = "updateConfig",
        .warm_pool_config = "warmPoolConfig",
    };
};

pub const UpdateNodegroupConfigOutput = struct {
    update: ?Update = null,

    pub const json_field_names = .{
        .update = "update",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateNodegroupConfigInput, options: CallOptions) !UpdateNodegroupConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "eks", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateNodegroupConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/node-groups/");
    try path_buf.appendSlice(allocator, input.nodegroup_name);
    try path_buf.appendSlice(allocator, "/update-config");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.labels) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"labels\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.node_repair_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nodeRepairConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.scaling_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"scalingConfig\":");
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
    if (input.warm_pool_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"warmPoolConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateNodegroupConfigOutput {
    var result: UpdateNodegroupConfigOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateNodegroupConfigOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
