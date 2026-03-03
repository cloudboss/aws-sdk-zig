const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AddonNamespaceConfigRequest = @import("addon_namespace_config_request.zig").AddonNamespaceConfigRequest;
const AddonPodIdentityAssociations = @import("addon_pod_identity_associations.zig").AddonPodIdentityAssociations;
const ResolveConflicts = @import("resolve_conflicts.zig").ResolveConflicts;
const Addon = @import("addon.zig").Addon;

pub const CreateAddonInput = struct {
    /// The name of the add-on. The name must match one of the names returned by
    /// `DescribeAddonVersions`.
    addon_name: []const u8,

    /// The version of the add-on. The version must match one of the versions
    /// returned by [
    /// `DescribeAddonVersions`
    /// ](https://docs.aws.amazon.com/eks/latest/APIReference/API_DescribeAddonVersions.html).
    addon_version: ?[]const u8 = null,

    /// A unique, case-sensitive identifier that you provide to ensure
    /// the idempotency of the request.
    client_request_token: ?[]const u8 = null,

    /// The name of your cluster.
    cluster_name: []const u8,

    /// The set of configuration values for the add-on that's created. The values
    /// that you
    /// provide are validated against the schema returned by
    /// `DescribeAddonConfiguration`.
    configuration_values: ?[]const u8 = null,

    /// The namespace configuration for the addon. If specified, this will override
    /// the default namespace for the addon.
    namespace_config: ?AddonNamespaceConfigRequest = null,

    /// An array of EKS Pod Identity associations to be created. Each association
    /// maps a Kubernetes service account to
    /// an IAM role.
    ///
    /// For more information, see [Attach an IAM Role to an Amazon EKS add-on
    /// using EKS Pod
    /// Identity](https://docs.aws.amazon.com/eks/latest/userguide/add-ons-iam.html)
    /// in the *Amazon EKS User Guide*.
    pod_identity_associations: ?[]const AddonPodIdentityAssociations = null,

    /// How to resolve field value conflicts for an Amazon EKS add-on. Conflicts are
    /// handled based
    /// on the value you choose:
    ///
    /// * **None** – If the self-managed version of
    /// the add-on is installed on your cluster, Amazon EKS doesn't change the
    /// value.
    /// Creation of the add-on might fail.
    ///
    /// * **Overwrite** – If the self-managed
    /// version of the add-on is installed on your cluster and the Amazon EKS
    /// default value
    /// is different than the existing value, Amazon EKS changes the value to the
    /// Amazon EKS
    /// default value.
    ///
    /// * **Preserve** – This is similar to the NONE
    /// option. If the self-managed version of the add-on is installed on your
    /// cluster
    /// Amazon EKS doesn't change the add-on resource properties. Creation of the
    /// add-on
    /// might fail if conflicts are detected. This option works differently during
    /// the
    /// update operation. For more information, see [
    /// `UpdateAddon`
    /// ](https://docs.aws.amazon.com/eks/latest/APIReference/API_UpdateAddon.html).
    ///
    /// If you don't currently have the self-managed version of the add-on installed
    /// on your
    /// cluster, the Amazon EKS add-on is installed. Amazon EKS sets all values to
    /// default values,
    /// regardless of the option that you specify.
    resolve_conflicts: ?ResolveConflicts = null,

    /// The Amazon Resource Name (ARN) of an existing IAM role to bind to the
    /// add-on's service account. The role must be assigned the IAM permissions
    /// required by the add-on. If you don't specify an existing IAM role, then the
    /// add-on uses the
    /// permissions assigned to the node IAM role. For more information, see [Amazon
    /// EKS node IAM
    /// role](https://docs.aws.amazon.com/eks/latest/userguide/create-node-role.html) in the *Amazon EKS User Guide*.
    ///
    /// To specify an existing IAM role, you must have an IAM OpenID Connect (OIDC)
    /// provider created for
    /// your cluster. For more information, see [Enabling
    /// IAM roles for service accounts on your
    /// cluster](https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html) in the
    /// *Amazon EKS User Guide*.
    service_account_role_arn: ?[]const u8 = null,

    /// Metadata that assists with categorization and organization.
    /// Each tag consists of a key and an optional value. You define both. Tags
    /// don't
    /// propagate to any other cluster or Amazon Web Services resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .addon_name = "addonName",
        .addon_version = "addonVersion",
        .client_request_token = "clientRequestToken",
        .cluster_name = "clusterName",
        .configuration_values = "configurationValues",
        .namespace_config = "namespaceConfig",
        .pod_identity_associations = "podIdentityAssociations",
        .resolve_conflicts = "resolveConflicts",
        .service_account_role_arn = "serviceAccountRoleArn",
        .tags = "tags",
    };
};

pub const CreateAddonOutput = struct {
    addon: ?Addon = null,

    pub const json_field_names = .{
        .addon = "addon",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAddonInput, options: Options) !CreateAddonOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAddonInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/addons");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"addonName\":");
    try aws.json.writeValue(@TypeOf(input.addon_name), input.addon_name, allocator, &body_buf);
    has_prev = true;
    if (input.addon_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"addonVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.configuration_values) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"configurationValues\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.namespace_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"namespaceConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.pod_identity_associations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"podIdentityAssociations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resolve_conflicts) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resolveConflicts\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.service_account_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"serviceAccountRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAddonOutput {
    var result: CreateAddonOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAddonOutput, body, allocator);
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
