const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessEntry = @import("access_entry.zig").AccessEntry;

pub const UpdateAccessEntryInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure
    /// the idempotency of the request.
    client_request_token: ?[]const u8 = null,

    /// The name of your cluster.
    cluster_name: []const u8,

    /// The value for `name` that you've specified for `kind: Group` as
    /// a `subject` in a Kubernetes `RoleBinding` or
    /// `ClusterRoleBinding` object. Amazon EKS doesn't confirm that the value for
    /// `name` exists in any bindings on your cluster. You can specify one or
    /// more names.
    ///
    /// Kubernetes authorizes the `principalArn` of the access entry to access any
    /// cluster objects that you've specified in a Kubernetes `Role` or
    /// `ClusterRole` object that is also specified in a binding's
    /// `roleRef`. For more information about creating Kubernetes
    /// `RoleBinding`, `ClusterRoleBinding`, `Role`, or
    /// `ClusterRole` objects, see [Using RBAC
    /// Authorization in the Kubernetes
    /// documentation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/).
    ///
    /// If you want Amazon EKS to authorize the `principalArn` (instead of, or in
    /// addition to Kubernetes authorizing the `principalArn`), you can associate
    /// one or
    /// more access policies to the access entry using `AssociateAccessPolicy`. If
    /// you associate any access policies, the `principalARN` has all permissions
    /// assigned in the associated access policies and all permissions in any
    /// Kubernetes
    /// `Role` or `ClusterRole` objects that the group names are bound
    /// to.
    kubernetes_groups: ?[]const []const u8 = null,

    /// The ARN of the IAM principal for the `AccessEntry`.
    principal_arn: []const u8,

    /// The username to authenticate to Kubernetes with. We recommend not specifying
    /// a username and
    /// letting Amazon EKS specify it for you. For more information about the value
    /// Amazon EKS specifies
    /// for you, or constraints before specifying your own username, see [Creating
    /// access
    /// entries](https://docs.aws.amazon.com/eks/latest/userguide/access-entries.html#creating-access-entries) in the *Amazon EKS User Guide*.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .cluster_name = "clusterName",
        .kubernetes_groups = "kubernetesGroups",
        .principal_arn = "principalArn",
        .username = "username",
    };
};

pub const UpdateAccessEntryOutput = struct {
    /// The ARN of the IAM principal for the `AccessEntry`.
    access_entry: ?AccessEntry = null,

    pub const json_field_names = .{
        .access_entry = "accessEntry",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAccessEntryInput, options: CallOptions) !UpdateAccessEntryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAccessEntryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/access-entries/");
    try path_buf.appendSlice(allocator, input.principal_arn);
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
    if (input.kubernetes_groups) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kubernetesGroups\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.username) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"username\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAccessEntryOutput {
    const result: UpdateAccessEntryOutput = try aws.json.parseJsonObject(
        UpdateAccessEntryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
