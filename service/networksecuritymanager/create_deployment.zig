const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicyReference = @import("policy_reference.zig").PolicyReference;
const ScopeReference = @import("scope_reference.zig").ScopeReference;
const DeploymentConfiguration = @import("deployment_configuration.zig").DeploymentConfiguration;
const AssociatedPolicy = @import("associated_policy.zig").AssociatedPolicy;
const AssociatedScope = @import("associated_scope.zig").AssociatedScope;
const DeploymentCoverageEntry = @import("deployment_coverage_entry.zig").DeploymentCoverageEntry;
const EntityStatus = @import("entity_status.zig").EntityStatus;
const DeploymentWarningEntry = @import("deployment_warning_entry.zig").DeploymentWarningEntry;

pub const CreateDeploymentInput = struct {
    /// The policies associated with the deployment.
    associated_policy_list: []const PolicyReference,

    /// The scope associated with the deployment. A deployment has exactly one
    /// scope.
    associated_scope_list: []const ScopeReference,

    /// A unique, case-sensitive token that you provide to ensure that the operation
    /// completes no more than one time. If you retry a request with the same client
    /// token and the same parameters, the service returns the result of the
    /// original successful request.
    client_token: ?[]const u8 = null,

    /// The configuration settings for the deployment.
    deployment_configuration: DeploymentConfiguration,

    /// A description of the deployment.
    deployment_description: ?[]const u8 = null,

    /// The name of the deployment.
    deployment_name: []const u8,

    /// Specifies whether to publish the resource. When `true`, the resource is
    /// saved in published (`ACTIVE`) state. When `false`, it is saved as a draft
    /// (`DRAFT`). Default: `true`.
    is_published: ?bool = null,

    /// The tags to add to the resource when it is created.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .associated_policy_list = "associatedPolicyList",
        .associated_scope_list = "associatedScopeList",
        .client_token = "clientToken",
        .deployment_configuration = "deploymentConfiguration",
        .deployment_description = "deploymentDescription",
        .deployment_name = "deploymentName",
        .is_published = "isPublished",
        .tags = "tags",
    };
};

pub const CreateDeploymentOutput = struct {
    /// The policies associated with the deployment.
    associated_policy_list: ?[]const AssociatedPolicy = null,

    /// The scope associated with the deployment. A deployment has exactly one
    /// scope.
    associated_scope_list: ?[]const AssociatedScope = null,

    /// The Amazon Resource Name (ARN) of the deployment.
    deployment_arn: []const u8,

    /// The configuration settings for the deployment.
    deployment_configuration: ?DeploymentConfiguration = null,

    /// The coverage information for the deployment. For each firewall type, it
    /// shows which policies have that firewall type and which in-scope resource
    /// types the firewall type protects.
    deployment_coverage: ?[]const DeploymentCoverageEntry = null,

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

    /// The time when the resource was last updated.
    updated_at: ?i64 = null,

    /// A token used for optimistic concurrency control. Each read and write returns
    /// an `updateToken`. Provide the most recent value on your next update to
    /// detect and prevent conflicting concurrent modifications.
    update_token: ?[]const u8 = null,

    /// The version of the resource.
    version: []const u8,

    /// Warnings about potential issues, such as a policy that has no applicable
    /// resources in the deployment's scope.
    warnings: ?[]const DeploymentWarningEntry = null,

    pub const json_field_names = .{
        .associated_policy_list = "associatedPolicyList",
        .associated_scope_list = "associatedScopeList",
        .deployment_arn = "deploymentArn",
        .deployment_configuration = "deploymentConfiguration",
        .deployment_coverage = "deploymentCoverage",
        .deployment_description = "deploymentDescription",
        .deployment_id = "deploymentId",
        .deployment_name = "deploymentName",
        .has_published_version = "hasPublishedVersion",
        .is_snapshot = "isSnapshot",
        .status = "status",
        .updated_at = "updatedAt",
        .update_token = "updateToken",
        .version = "version",
        .warnings = "warnings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDeploymentInput, options: CallOptions) !CreateDeploymentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("network-security-manager", "Network Security Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/deployments";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"associatedPolicyList\":");
    try aws.json.writeValue(@TypeOf(input.associated_policy_list), input.associated_policy_list, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"associatedScopeList\":");
    try aws.json.writeValue(@TypeOf(input.associated_scope_list), input.associated_scope_list, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"deploymentConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.deployment_configuration), input.deployment_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.deployment_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deploymentDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"deploymentName\":");
    try aws.json.writeValue(@TypeOf(input.deployment_name), input.deployment_name, allocator, &body_buf);
    has_prev = true;
    if (input.is_published) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"isPublished\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDeploymentOutput {
    const result: CreateDeploymentOutput = try aws.json.parseJsonObject(
        CreateDeploymentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
