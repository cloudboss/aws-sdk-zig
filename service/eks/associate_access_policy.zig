const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessScope = @import("access_scope.zig").AccessScope;
const AssociatedAccessPolicy = @import("associated_access_policy.zig").AssociatedAccessPolicy;

pub const AssociateAccessPolicyInput = struct {
    /// The scope for the `AccessPolicy`. You can scope access policies to an
    /// entire cluster or to specific Kubernetes namespaces.
    access_scope: AccessScope,

    /// The name of your cluster.
    cluster_name: []const u8,

    /// The ARN of the `AccessPolicy` that you're associating. For a list of
    /// ARNs, use `ListAccessPolicies`.
    policy_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM user or role for the `AccessEntry`
    /// that you're
    /// associating the access policy to.
    principal_arn: []const u8,

    pub const json_field_names = .{
        .access_scope = "accessScope",
        .cluster_name = "clusterName",
        .policy_arn = "policyArn",
        .principal_arn = "principalArn",
    };
};

pub const AssociateAccessPolicyOutput = struct {
    /// The `AccessPolicy` and scope associated to the
    /// `AccessEntry`.
    associated_access_policy: ?AssociatedAccessPolicy = null,

    /// The name of your cluster.
    cluster_name: ?[]const u8 = null,

    /// The ARN of the IAM principal for the `AccessEntry`.
    principal_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .associated_access_policy = "associatedAccessPolicy",
        .cluster_name = "clusterName",
        .principal_arn = "principalArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateAccessPolicyInput, options: CallOptions) !AssociateAccessPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateAccessPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/access-entries/");
    try path_buf.appendSlice(allocator, input.principal_arn);
    try path_buf.appendSlice(allocator, "/access-policies");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"accessScope\":");
    try aws.json.writeValue(@TypeOf(input.access_scope), input.access_scope, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyArn\":");
    try aws.json.writeValue(@TypeOf(input.policy_arn), input.policy_arn, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateAccessPolicyOutput {
    var result: AssociateAccessPolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AssociateAccessPolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
