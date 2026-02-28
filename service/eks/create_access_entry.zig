const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AccessEntry = @import("access_entry.zig").AccessEntry;

pub const CreateAccessEntryInput = struct {
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

    /// The ARN of the IAM principal for the `AccessEntry`. You can specify one ARN
    /// for each access entry. You can't specify the
    /// same ARN in more than one access entry. This value can't be changed after
    /// access entry
    /// creation.
    ///
    /// The valid principals differ depending on the type of the access entry in the
    /// `type` field. For `STANDARD` access entries, you can use every
    /// IAM principal type. For nodes (`EC2` (for EKS Auto Mode),
    /// `EC2_LINUX`, `EC2_WINDOWS`, `FARGATE_LINUX`, and
    /// `HYBRID_LINUX`), the only valid ARN is IAM roles.
    ///
    /// You can't use the STS session principal type with access entries because
    /// this is a
    /// temporary principal for each session and not a permanent identity that can
    /// be assigned
    /// permissions.
    ///
    /// [IAM best
    /// practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#bp-users-federation-idp) recommend using IAM roles with temporary credentials, rather
    /// than IAM users with long-term credentials.
    principal_arn: []const u8,

    /// Metadata that assists with categorization and organization.
    /// Each tag consists of a key and an optional value. You define both. Tags
    /// don't
    /// propagate to any other cluster or Amazon Web Services resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the new access entry. Valid values are `STANDARD`,
    /// `FARGATE_LINUX`, `EC2_LINUX`, `EC2_WINDOWS`,
    /// `EC2` (for EKS Auto Mode), `HYBRID_LINUX`, and
    /// `HYPERPOD_LINUX`.
    ///
    /// If the `principalArn` is for an IAM role that's used for self-managed
    /// Amazon EC2 nodes, specify `EC2_LINUX` or `EC2_WINDOWS`. Amazon EKS grants
    /// the necessary permissions to the node for you. If the `principalArn` is for
    /// any other purpose, specify `STANDARD`. If you don't specify a value, Amazon
    /// EKS
    /// sets the value to `STANDARD`. If you have the access mode of the cluster set
    /// to `API_AND_CONFIG_MAP`, it's unnecessary to create access entries for IAM
    /// roles used with Fargate profiles or managed Amazon EC2 nodes, because Amazon
    /// EKS creates entries
    /// in the `aws-auth`
    /// `ConfigMap` for the roles. You can't change this value once you've created
    /// the access entry.
    ///
    /// If you set the value to `EC2_LINUX` or `EC2_WINDOWS`, you can't
    /// specify values for `kubernetesGroups`, or associate an
    /// `AccessPolicy` to the access entry.
    type: ?[]const u8 = null,

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
        .tags = "tags",
        .type = "type",
        .username = "username",
    };
};

pub const CreateAccessEntryOutput = struct {
    access_entry: ?AccessEntry = null,

    pub const json_field_names = .{
        .access_entry = "accessEntry",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAccessEntryInput, options: Options) !CreateAccessEntryOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateAccessEntryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/clusters/");
    try path_buf.appendSlice(alloc, input.cluster_name);
    try path_buf.appendSlice(alloc, "/access-entries");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.kubernetes_groups) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"kubernetesGroups\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"principalArn\":");
    try aws.json.writeValue(@TypeOf(input.principal_arn), input.principal_arn, alloc, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.type) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"type\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.username) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"username\":");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateAccessEntryOutput {
    var result: CreateAccessEntryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAccessEntryOutput, body, alloc);
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
