const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PodIdentityAssociation = @import("pod_identity_association.zig").PodIdentityAssociation;

pub const UpdatePodIdentityAssociationInput = struct {
    /// The ID of the association to be updated.
    association_id: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure
    /// the idempotency of the request.
    client_request_token: ?[]const u8 = null,

    /// The name of the cluster that you want to update the association in.
    cluster_name: []const u8,

    /// Disable the automatic sessions tags that are appended by EKS Pod Identity.
    ///
    /// EKS Pod Identity adds a pre-defined set of session tags when it assumes the
    /// role. You
    /// can use these tags to author a single role that can work across resources by
    /// allowing
    /// access to Amazon Web Services resources based on matching tags. By default,
    /// EKS Pod Identity attaches
    /// six tags, including tags for cluster name, namespace, and service account
    /// name. For the
    /// list of tags added by EKS Pod Identity, see [List of session tags
    /// added by EKS Pod
    /// Identity](https://docs.aws.amazon.com/eks/latest/userguide/pod-id-abac.html#pod-id-abac-tags) in the *Amazon EKS User Guide*.
    ///
    /// Amazon Web Services compresses inline session policies, managed policy ARNs,
    /// and session tags into a
    /// packed binary format that has a separate limit. If you receive a
    /// `PackedPolicyTooLarge` error
    /// indicating the packed binary format has exceeded the size limit, you can
    /// attempt to reduce
    /// the size by disabling the session tags added by EKS Pod Identity.
    disable_session_tags: ?bool = null,

    /// An optional IAM policy in JSON format (as an escaped string) that applies
    /// additional
    /// restrictions to this pod identity association beyond the IAM policies
    /// attached to the
    /// IAM role. This policy is applied as the intersection of the role's policies
    /// and this
    /// policy, allowing you to reduce the permissions that applications in the pods
    /// can use.
    /// Use this policy to enforce least privilege access while still leveraging a
    /// shared IAM
    /// role across multiple applications.
    ///
    /// **Important considerations**
    ///
    /// * **Session tags:** When using this policy,
    /// `disableSessionTags` must be set to `true`.
    ///
    /// * **Target role permissions:** If you specify both
    /// a `TargetRoleArn` and a policy, the policy restrictions apply only to
    /// the target role's permissions, not to the initial role used for assuming the
    /// target role.
    policy: ?[]const u8 = null,

    /// The new IAM role to change in the association.
    role_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the target IAM role to associate with the
    /// service account. This
    /// role is assumed by using the EKS Pod Identity association role, then the
    /// credentials for this
    /// role are injected into the Pod.
    ///
    /// When you run applications on Amazon EKS, your application might need to
    /// access Amazon Web Services
    /// resources from a different role that exists in the same or different Amazon
    /// Web Services account. For
    /// example, your application running in “Account A” might need to access
    /// resources, such as
    /// buckets in “Account B” or within “Account A” itself. You can create a
    /// association to
    /// access Amazon Web Services resources in “Account B” by creating two IAM
    /// roles: a role in “Account A”
    /// and a role in “Account B” (which can be the same or different account), each
    /// with the
    /// necessary trust and permission policies. After you provide these roles in
    /// the *IAM role*
    /// and *Target IAM role* fields, EKS will perform role chaining to ensure your
    /// application
    /// gets the required permissions. This means Role A will assume Role B,
    /// allowing your Pods
    /// to securely access resources like S3 buckets in the target account.
    target_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_id = "associationId",
        .client_request_token = "clientRequestToken",
        .cluster_name = "clusterName",
        .disable_session_tags = "disableSessionTags",
        .policy = "policy",
        .role_arn = "roleArn",
        .target_role_arn = "targetRoleArn",
    };
};

pub const UpdatePodIdentityAssociationOutput = struct {
    /// The full description of the association that was updated.
    association: ?PodIdentityAssociation = null,

    pub const json_field_names = .{
        .association = "association",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePodIdentityAssociationInput, options: CallOptions) !UpdatePodIdentityAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePodIdentityAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/pod-identity-associations/");
    try path_buf.appendSlice(allocator, input.association_id);
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
    if (input.disable_session_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"disableSessionTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"policy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.target_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"targetRoleArn\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePodIdentityAssociationOutput {
    const result: UpdatePodIdentityAssociationOutput = try aws.json.parseJsonObject(
        UpdatePodIdentityAssociationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
