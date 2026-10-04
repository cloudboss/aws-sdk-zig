const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AddonPodIdentityAssociations = @import("addon_pod_identity_associations.zig").AddonPodIdentityAssociations;
const ResolveConflicts = @import("resolve_conflicts.zig").ResolveConflicts;
const Update = @import("update.zig").Update;

pub const UpdateAddonInput = struct {
    /// The name of the add-on. The name must match one of the names returned by [
    /// `ListAddons`
    /// ](https://docs.aws.amazon.com/eks/latest/APIReference/API_ListAddons.html).
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

    /// An array of EKS Pod Identity associations to be updated. Each association
    /// maps a Kubernetes service account to an IAM role. If this value is left
    /// blank, no change.
    /// If an empty array is provided, existing associations owned by the add-on are
    /// deleted.
    ///
    /// For more information, see [Attach an IAM Role to an Amazon EKS add-on
    /// using EKS Pod
    /// Identity](https://docs.aws.amazon.com/eks/latest/userguide/add-ons-iam.html)
    /// in the *Amazon EKS User Guide*.
    pod_identity_associations: ?[]const AddonPodIdentityAssociations = null,

    /// How to resolve field value conflicts for an Amazon EKS add-on if you've
    /// changed a value
    /// from the Amazon EKS default value. Conflicts are handled based on the option
    /// you
    /// choose:
    ///
    /// * **None** – Amazon EKS doesn't change the value.
    /// The update might fail.
    ///
    /// * **Overwrite** – Amazon EKS overwrites the
    /// changed value back to the Amazon EKS default value.
    ///
    /// * **Preserve** – Amazon EKS preserves the value.
    /// If you choose this option, we recommend that you test any field and value
    /// changes on a non-production cluster before updating the add-on on your
    /// production cluster.
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

    pub const json_field_names = .{
        .addon_name = "addonName",
        .addon_version = "addonVersion",
        .client_request_token = "clientRequestToken",
        .cluster_name = "clusterName",
        .configuration_values = "configurationValues",
        .pod_identity_associations = "podIdentityAssociations",
        .resolve_conflicts = "resolveConflicts",
        .service_account_role_arn = "serviceAccountRoleArn",
    };
};

pub const UpdateAddonOutput = struct {
    update: ?Update = null,

    pub const json_field_names = .{
        .update = "update",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAddonInput, options: CallOptions) !UpdateAddonOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAddonInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/addons/");
    try path_buf.appendSlice(allocator, input.addon_name);
    try path_buf.appendSlice(allocator, "/update");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAddonOutput {
    const result: UpdateAddonOutput = try aws.json.parseJsonObject(
        UpdateAddonOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
