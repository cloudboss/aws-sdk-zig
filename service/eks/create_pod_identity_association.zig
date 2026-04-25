const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const PodIdentityAssociation = @import("pod_identity_association.zig").PodIdentityAssociation;

pub const CreatePodIdentityAssociationInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure
    /// the idempotency of the request.
    client_request_token: ?[]const u8 = null,

    /// The name of the cluster to create the EKS Pod Identity association in.
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
    /// `PackedPolicyTooLarge` error indicating the packed binary format has
    /// exceeded the size limit, you can attempt to reduce the size by disabling the
    /// session
    /// tags added by EKS Pod Identity.
    disable_session_tags: ?bool = null,

    /// The name of the Kubernetes namespace inside the cluster to create the EKS
    /// Pod Identity association in. The
    /// service account and the Pods that use the service account must be in this
    /// namespace.
    namespace: []const u8,

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

    /// The Amazon Resource Name (ARN) of the IAM role to associate with the service
    /// account. The EKS Pod Identity
    /// agent manages credentials to assume this role for applications in the
    /// containers in the
    /// Pods that use this service account.
    role_arn: []const u8,

    /// The name of the Kubernetes service account inside the cluster to associate
    /// the IAM
    /// credentials with.
    service_account: []const u8,

    /// Metadata that assists with categorization and organization.
    /// Each tag consists of a key and an optional value. You define both. Tags
    /// don't
    /// propagate to any other cluster or Amazon Web Services resources.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource – 50
    ///
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only
    /// one value.
    ///
    /// * Maximum key length – 128 Unicode characters in UTF-8
    ///
    /// * Maximum value length – 256 Unicode characters in UTF-8
    ///
    /// * If your tagging schema is used across multiple services and resources,
    /// remember that other services may have restrictions on allowed characters.
    /// Generally allowed characters are: letters, numbers, and spaces representable
    /// in
    /// UTF-8, and the following characters: + - = . _ : / @.
    ///
    /// * Tag keys and values are case-sensitive.
    ///
    /// * Do not use `aws:`, `AWS:`, or any upper or lowercase
    /// combination of such as a prefix for either keys or values as it is reserved
    /// for
    /// Amazon Web Services use. You cannot edit or delete tag keys or values with
    /// this prefix. Tags with
    /// this prefix do not count against your tags per resource limit.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the target IAM role to associate with the
    /// service account. This role
    /// is assumed by using the EKS Pod Identity association role, then the
    /// credentials for this
    /// role are injected into the Pod.
    ///
    /// When you run applications on Amazon EKS, your application might need to
    /// access Amazon Web Services
    /// resources from a different role that exists in the same or different Amazon
    /// Web Services account. For
    /// example, your application running in “Account A” might need to access
    /// resources, such as
    /// Amazon S3 buckets in “Account B” or within “Account A” itself. You can
    /// create a association
    /// to access Amazon Web Services resources in “Account B” by creating two IAM
    /// roles: a role in “Account
    /// A” and a role in “Account B” (which can be the same or different account),
    /// each with the
    /// necessary trust and permission policies. After you provide these roles in
    /// the
    /// *IAM role* and *Target IAM role* fields, EKS
    /// will perform role chaining to ensure your application gets the required
    /// permissions.
    /// This means Role A will assume Role B, allowing your Pods to securely access
    /// resources
    /// like S3 buckets in the target account.
    target_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .cluster_name = "clusterName",
        .disable_session_tags = "disableSessionTags",
        .namespace = "namespace",
        .policy = "policy",
        .role_arn = "roleArn",
        .service_account = "serviceAccount",
        .tags = "tags",
        .target_role_arn = "targetRoleArn",
    };
};

pub const CreatePodIdentityAssociationOutput = struct {
    /// The full description of your new association.
    ///
    /// The description includes an ID for the association. Use the ID of the
    /// association in further
    /// actions to manage the association.
    association: ?PodIdentityAssociation = null,

    pub const json_field_names = .{
        .association = "association",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePodIdentityAssociationInput, options: CallOptions) !CreatePodIdentityAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePodIdentityAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/pod-identity-associations");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"namespace\":");
    try aws.json.writeValue(@TypeOf(input.namespace), input.namespace, allocator, &body_buf);
    has_prev = true;
    if (input.policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"policy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"serviceAccount\":");
    try aws.json.writeValue(@TypeOf(input.service_account), input.service_account, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePodIdentityAssociationOutput {
    var result: CreatePodIdentityAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePodIdentityAssociationOutput, body, allocator);
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
