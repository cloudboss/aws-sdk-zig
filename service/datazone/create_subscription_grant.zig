const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetTargetNameMap = @import("asset_target_name_map.zig").AssetTargetNameMap;
const GrantedEntityInput = @import("granted_entity_input.zig").GrantedEntityInput;
const SubscribedAsset = @import("subscribed_asset.zig").SubscribedAsset;
const GrantedEntity = @import("granted_entity.zig").GrantedEntity;
const SubscriptionGrantOverallStatus = @import("subscription_grant_overall_status.zig").SubscriptionGrantOverallStatus;

pub const CreateSubscriptionGrantInput = struct {
    /// The names of the assets for which the subscription grant is created.
    asset_target_names: ?[]const AssetTargetNameMap = null,

    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which the subscription grant is
    /// created.
    domain_identifier: []const u8,

    /// The ID of the environment in which the subscription grant is created.
    environment_identifier: []const u8,

    /// The entity to which the subscription is to be granted.
    granted_entity: GrantedEntityInput,

    /// The ID of the subscription target for which the subscription grant is
    /// created.
    subscription_target_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset_target_names = "assetTargetNames",
        .client_token = "clientToken",
        .domain_identifier = "domainIdentifier",
        .environment_identifier = "environmentIdentifier",
        .granted_entity = "grantedEntity",
        .subscription_target_identifier = "subscriptionTargetIdentifier",
    };
};

pub const CreateSubscriptionGrantOutput = struct {
    /// The assets for which the subscription grant is created.
    assets: ?[]const SubscribedAsset = null,

    /// A timestamp of when the subscription grant is created.
    created_at: i64,

    /// The Amazon DataZone user who created the subscription grant.
    created_by: []const u8,

    /// The ID of the Amazon DataZone domain in which the subscription grant is
    /// created.
    domain_id: []const u8,

    /// The environment ID for which subscription grant is created.
    environment_id: ?[]const u8 = null,

    /// The entity to which the subscription is granted.
    granted_entity: ?GrantedEntity = null,

    /// The ID of the subscription grant.
    id: []const u8,

    /// The status of the subscription grant.
    status: SubscriptionGrantOverallStatus,

    /// The identifier of the subscription grant.
    subscription_id: ?[]const u8 = null,

    /// The ID of the subscription target for which the subscription grant is
    /// created.
    subscription_target_id: []const u8,

    /// A timestamp of when the subscription grant was updated.
    updated_at: i64,

    /// The Amazon DataZone user who updated the subscription grant.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .assets = "assets",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .environment_id = "environmentId",
        .granted_entity = "grantedEntity",
        .id = "id",
        .status = "status",
        .subscription_id = "subscriptionId",
        .subscription_target_id = "subscriptionTargetId",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSubscriptionGrantInput, options: CallOptions) !CreateSubscriptionGrantOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSubscriptionGrantInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/subscription-grants");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.asset_target_names) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assetTargetNames\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"environmentIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.environment_identifier), input.environment_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"grantedEntity\":");
    try aws.json.writeValue(@TypeOf(input.granted_entity), input.granted_entity, allocator, &body_buf);
    has_prev = true;
    if (input.subscription_target_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"subscriptionTargetIdentifier\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSubscriptionGrantOutput {
    var result: CreateSubscriptionGrantOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSubscriptionGrantOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
