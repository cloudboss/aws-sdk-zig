const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubscribedAsset = @import("subscribed_asset.zig").SubscribedAsset;
const GrantedEntity = @import("granted_entity.zig").GrantedEntity;
const SubscriptionGrantOverallStatus = @import("subscription_grant_overall_status.zig").SubscriptionGrantOverallStatus;

pub const GetSubscriptionGrantInput = struct {
    /// The ID of the Amazon DataZone domain in which the subscription grant exists.
    domain_identifier: []const u8,

    /// The ID of the subscription grant.
    identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
    };
};

pub const GetSubscriptionGrantOutput = struct {
    /// The assets for which the subscription grant is created.
    assets: ?[]const SubscribedAsset = null,

    /// The timestamp of when the subscription grant is created.
    created_at: i64,

    /// The Amazon DataZone user who created the subscription grant.
    created_by: []const u8,

    /// The ID of the Amazon DataZone domain in which the subscription grant exists.
    domain_id: []const u8,

    /// The environment ID of the subscription grant.
    environment_id: ?[]const u8 = null,

    /// The entity to which the subscription is granted.
    granted_entity: ?GrantedEntity = null,

    /// The ID of the subscription grant.
    id: []const u8,

    /// The status of the subscription grant.
    status: SubscriptionGrantOverallStatus,

    /// The identifier of the subscription.
    subscription_id: ?[]const u8 = null,

    /// The subscription target ID associated with the subscription grant.
    subscription_target_id: []const u8,

    /// The timestamp of when the subscription grant was upated.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSubscriptionGrantInput, options: CallOptions) !GetSubscriptionGrantOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSubscriptionGrantInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/subscription-grants/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSubscriptionGrantOutput {
    var result: GetSubscriptionGrantOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSubscriptionGrantOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
