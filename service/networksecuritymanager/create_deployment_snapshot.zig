const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssociatedPolicy = @import("associated_policy.zig").AssociatedPolicy;
const AssociatedScope = @import("associated_scope.zig").AssociatedScope;
const DeploymentConfiguration = @import("deployment_configuration.zig").DeploymentConfiguration;
const EntityStatus = @import("entity_status.zig").EntityStatus;

pub const CreateDeploymentSnapshotInput = struct {
    /// A unique, case-sensitive token that you provide to ensure that the operation
    /// completes no more than one time. If you retry a request with the same client
    /// token and the same parameters, the service returns the result of the
    /// original successful request.
    client_token: ?[]const u8 = null,

    /// The identifier of the deployment. This is the deployment's Amazon Resource
    /// Name (ARN).
    deployment_identifier: []const u8,

    /// The tags to add to the snapshot when it is created.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .deployment_identifier = "deploymentIdentifier",
        .tags = "tags",
    };
};

pub const CreateDeploymentSnapshotOutput = struct {
    /// The policies associated with the deployment.
    associated_policy_list: ?[]const AssociatedPolicy = null,

    /// The scope associated with the deployment. A deployment has exactly one
    /// scope.
    associated_scope_list: ?[]const AssociatedScope = null,

    /// The Amazon Resource Name (ARN) of the deployment.
    deployment_arn: []const u8,

    /// The configuration settings for the deployment.
    deployment_configuration: ?DeploymentConfiguration = null,

    /// A description of the deployment.
    deployment_description: ?[]const u8 = null,

    /// The service-generated id of the deployment.
    deployment_id: []const u8,

    /// The name of the deployment.
    deployment_name: []const u8,

    /// Specifies whether a published version of the resource exists.
    has_published_version: ?bool = null,

    /// Specifies whether the resource is a snapshot of a published version.
    is_snapshot: ?bool = null,

    /// The current status of the resource: `DRAFT` (unpublished, editable) or
    /// `ACTIVE` (published, in use).
    status: EntityStatus,

    /// The time when the snapshot was created.
    updated_at: ?i64 = null,

    /// A token used for optimistic concurrency control. Each read and write returns
    /// an `updateToken`. Provide the most recent value on your next update to
    /// detect and prevent conflicting concurrent modifications.
    update_token: ?[]const u8 = null,

    /// The version of the resource.
    version: []const u8,

    pub const json_field_names = .{
        .associated_policy_list = "associatedPolicyList",
        .associated_scope_list = "associatedScopeList",
        .deployment_arn = "deploymentArn",
        .deployment_configuration = "deploymentConfiguration",
        .deployment_description = "deploymentDescription",
        .deployment_id = "deploymentId",
        .deployment_name = "deploymentName",
        .has_published_version = "hasPublishedVersion",
        .is_snapshot = "isSnapshot",
        .status = "status",
        .updated_at = "updatedAt",
        .update_token = "updateToken",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDeploymentSnapshotInput, options: CallOptions) !CreateDeploymentSnapshotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "network-security-manager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDeploymentSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("network-security-manager", "Network Security Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/deployments/");
    try path_buf.appendSlice(allocator, input.deployment_identifier);
    try path_buf.appendSlice(allocator, "/snapshots");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDeploymentSnapshotOutput {
    const result: CreateDeploymentSnapshotOutput = try aws.json.parseJsonObject(
        CreateDeploymentSnapshotOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
