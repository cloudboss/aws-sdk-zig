const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubscriptionGrantCreationMode = @import("subscription_grant_creation_mode.zig").SubscriptionGrantCreationMode;
const SubscriptionTargetForm = @import("subscription_target_form.zig").SubscriptionTargetForm;

pub const GetSubscriptionTargetInput = struct {
    /// The ID of the Amazon DataZone domain in which the subscription target
    /// exists.
    domain_identifier: []const u8,

    /// The ID of the environment associated with the subscription target.
    environment_identifier: []const u8,

    /// The ID of the subscription target.
    identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .environment_identifier = "environmentIdentifier",
        .identifier = "identifier",
    };
};

pub const GetSubscriptionTargetOutput = struct {
    /// The asset types associated with the subscription target.
    applicable_asset_types: ?[]const []const u8 = null,

    /// The authorized principals of the subscription target.
    authorized_principals: ?[]const []const u8 = null,

    /// The timestamp of when the subscription target was created.
    created_at: i64,

    /// The Amazon DataZone user who created the subscription target.
    created_by: []const u8,

    /// The ID of the Amazon DataZone domain in which the subscription target
    /// exists.
    domain_id: []const u8,

    /// The ID of the environment associated with the subscription target.
    environment_id: []const u8,

    /// The ID of the subscription target.
    id: []const u8,

    /// The manage access role with which the subscription target was created.
    manage_access_role: ?[]const u8 = null,

    /// The name of the subscription target.
    name: []const u8,

    /// The ID of the project associated with the subscription target.
    project_id: []const u8,

    /// The provider of the subscription target.
    provider: []const u8,

    /// Determines the subscription grant creation mode for this target, defining if
    /// grants are auto-created upon subscription approval or managed manually.
    subscription_grant_creation_mode: ?SubscriptionGrantCreationMode = null,

    /// The configuration of teh subscription target.
    subscription_target_config: ?[]const SubscriptionTargetForm = null,

    /// The type of the subscription target.
    type: []const u8,

    /// The timestamp of when the subscription target was updated.
    updated_at: ?i64 = null,

    /// The Amazon DataZone user who updated the subscription target.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .applicable_asset_types = "applicableAssetTypes",
        .authorized_principals = "authorizedPrincipals",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .environment_id = "environmentId",
        .id = "id",
        .manage_access_role = "manageAccessRole",
        .name = "name",
        .project_id = "projectId",
        .provider = "provider",
        .subscription_grant_creation_mode = "subscriptionGrantCreationMode",
        .subscription_target_config = "subscriptionTargetConfig",
        .type = "type",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSubscriptionTargetInput, options: CallOptions) !GetSubscriptionTargetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSubscriptionTargetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.environment_identifier);
    try path_buf.appendSlice(allocator, "/subscription-targets/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSubscriptionTargetOutput {
    const result: GetSubscriptionTargetOutput = try aws.json.parseJsonObject(
        GetSubscriptionTargetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
