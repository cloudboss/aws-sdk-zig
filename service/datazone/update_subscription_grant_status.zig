const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FailureCause = @import("failure_cause.zig").FailureCause;
const SubscriptionGrantStatus = @import("subscription_grant_status.zig").SubscriptionGrantStatus;
const SubscribedAsset = @import("subscribed_asset.zig").SubscribedAsset;
const GrantedEntity = @import("granted_entity.zig").GrantedEntity;
const SubscriptionGrantOverallStatus = @import("subscription_grant_overall_status.zig").SubscriptionGrantOverallStatus;

pub const UpdateSubscriptionGrantStatusInput = struct {
    /// The identifier of the asset the subscription grant status of which is to be
    /// updated.
    asset_identifier: []const u8,

    /// The identifier of the Amazon DataZone domain in which a subscription grant
    /// status is to be updated.
    domain_identifier: []const u8,

    /// Specifies the error message that is returned if the operation cannot be
    /// successfully completed.
    failure_cause: ?FailureCause = null,

    /// The identifier of the subscription grant the status of which is to be
    /// updated.
    identifier: []const u8,

    /// The status to be updated as part of the `UpdateSubscriptionGrantStatus`
    /// action.
    status: SubscriptionGrantStatus,

    /// The target name to be updated as part of the `UpdateSubscriptionGrantStatus`
    /// action.
    target_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset_identifier = "assetIdentifier",
        .domain_identifier = "domainIdentifier",
        .failure_cause = "failureCause",
        .identifier = "identifier",
        .status = "status",
        .target_name = "targetName",
    };
};

pub const UpdateSubscriptionGrantStatusOutput = struct {
    /// The details of the asset for which the subscription grant is created.
    assets: ?[]const SubscribedAsset = null,

    /// The timestamp of when the subscription grant status was created.
    created_at: i64,

    /// The Amazon DataZone domain user who created the subscription grant status.
    created_by: []const u8,

    /// The identifier of the Amazon DataZone domain in which a subscription grant
    /// status is to be updated.
    domain_id: []const u8,

    /// The ID of the environment in which the subscription grant is updated.
    environment_id: ?[]const u8 = null,

    /// The granted entity to be updated as part of the
    /// `UpdateSubscriptionGrantStatus` action.
    granted_entity: ?GrantedEntity = null,

    /// The identifier of the subscription grant.
    id: []const u8,

    /// The status to be updated as part of the `UpdateSubscriptionGrantStatus`
    /// action.
    status: SubscriptionGrantOverallStatus,

    /// The identifier of the subscription.
    subscription_id: ?[]const u8 = null,

    /// The identifier of the subscription target whose subscription grant status is
    /// to be updated.
    subscription_target_id: []const u8,

    /// The timestamp of when the subscription grant status is to be updated.
    updated_at: i64,

    /// The Amazon DataZone user who updated the subscription grant status.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSubscriptionGrantStatusInput, options: CallOptions) !UpdateSubscriptionGrantStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSubscriptionGrantStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/subscription-grants/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/status/");
    try path_buf.appendSlice(allocator, input.asset_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.failure_cause) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"failureCause\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"status\":");
    try aws.json.writeValue(@TypeOf(input.status), input.status, allocator, &body_buf);
    has_prev = true;
    if (input.target_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"targetName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSubscriptionGrantStatusOutput {
    var result: UpdateSubscriptionGrantStatusOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateSubscriptionGrantStatusOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
