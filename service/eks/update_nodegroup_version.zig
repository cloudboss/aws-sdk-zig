const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LaunchTemplateSpecification = @import("launch_template_specification.zig").LaunchTemplateSpecification;
const Update = @import("update.zig").Update;

pub const UpdateNodegroupVersionInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure
    /// the idempotency of the request.
    client_request_token: ?[]const u8 = null,

    /// The name of your cluster.
    cluster_name: []const u8,

    /// Force the update if any `Pod` on the existing node group can't be drained
    /// due to a `Pod` disruption budget issue. If an update fails because all Pods
    /// can't be drained, you can force the update after it fails to terminate the
    /// old node
    /// whether or not any `Pod` is running on the node.
    force: ?bool = null,

    /// An object representing a node group's launch template specification. You can
    /// only
    /// update a node group using a launch template if the node group was originally
    /// deployed
    /// with a launch template. When updating, you must specify the same launch
    /// template ID or
    /// name that was used to create the node group.
    launch_template: ?LaunchTemplateSpecification = null,

    /// The name of the managed node group to update.
    nodegroup_name: []const u8,

    /// The AMI version of the Amazon EKS optimized AMI to use for the update. By
    /// default, the
    /// latest available AMI version for the node group's Kubernetes version is
    /// used. For information
    /// about Linux versions, see [Amazon EKS optimized Amazon Linux AMI
    /// versions](https://docs.aws.amazon.com/eks/latest/userguide/eks-linux-ami-versions.html) in the
    /// *Amazon EKS User Guide*. Amazon EKS managed node groups support the November
    /// 2022 and later releases
    /// of the Windows AMIs. For information about Windows versions, see [Amazon EKS
    /// optimized Windows AMI
    /// versions](https://docs.aws.amazon.com/eks/latest/userguide/eks-ami-versions-windows.html) in the *Amazon EKS User Guide*.
    ///
    /// If you specify `launchTemplate`, and your launch template uses a custom AMI,
    /// then don't specify
    /// `releaseVersion`, or the node group update will fail.
    /// For more information about using launch templates with Amazon EKS, see
    /// [Customizing managed nodes with launch
    /// templates](https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html) in the *Amazon EKS User Guide*.
    release_version: ?[]const u8 = null,

    /// The Kubernetes version to update to. If no version is specified, then the
    /// node group
    /// will be updated to match the cluster's current Kubernetes version, and the
    /// latest available
    /// AMI for that version will be used. You can also specify the Kubernetes
    /// version of the cluster
    /// to update the node group to the latest AMI version of the cluster's
    /// Kubernetes version.
    /// If you specify `launchTemplate`, and your launch template uses a custom AMI,
    /// then don't specify `version`,
    /// or the node group update will fail. For more information about using launch
    /// templates with Amazon EKS, see [Customizing managed nodes with launch
    /// templates](https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html) in the *Amazon EKS User Guide*.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .cluster_name = "clusterName",
        .force = "force",
        .launch_template = "launchTemplate",
        .nodegroup_name = "nodegroupName",
        .release_version = "releaseVersion",
        .version = "version",
    };
};

pub const UpdateNodegroupVersionOutput = struct {
    update: ?Update = null,

    pub const json_field_names = .{
        .update = "update",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateNodegroupVersionInput, options: CallOptions) !UpdateNodegroupVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateNodegroupVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/node-groups/");
    try path_buf.appendSlice(allocator, input.nodegroup_name);
    try path_buf.appendSlice(allocator, "/update-version");
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
    if (input.force) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"force\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.launch_template) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"launchTemplate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.release_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"releaseVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"version\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateNodegroupVersionOutput {
    const result: UpdateNodegroupVersionOutput = try aws.json.parseJsonObject(
        UpdateNodegroupVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
