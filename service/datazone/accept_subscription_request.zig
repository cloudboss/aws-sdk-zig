const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetPermission = @import("asset_permission.zig").AssetPermission;
const AcceptedAssetScope = @import("accepted_asset_scope.zig").AcceptedAssetScope;
const FormOutput = @import("form_output.zig").FormOutput;
const SubscriptionRequestStatus = @import("subscription_request_status.zig").SubscriptionRequestStatus;
const SubscribedListing = @import("subscribed_listing.zig").SubscribedListing;
const SubscribedPrincipal = @import("subscribed_principal.zig").SubscribedPrincipal;

pub const AcceptSubscriptionRequestInput = struct {
    /// The asset permissions of the accept subscription request.
    asset_permissions: ?[]const AssetPermission = null,

    /// The asset scopes of the accept subscription request.
    asset_scopes: ?[]const AcceptedAssetScope = null,

    /// A description that specifies the reason for accepting the specified
    /// subscription request.
    decision_comment: ?[]const u8 = null,

    /// The Amazon DataZone domain where the specified subscription request is being
    /// accepted.
    domain_identifier: []const u8,

    /// The unique identifier of the subscription request that is to be accepted.
    identifier: []const u8,

    pub const json_field_names = .{
        .asset_permissions = "assetPermissions",
        .asset_scopes = "assetScopes",
        .decision_comment = "decisionComment",
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
    };
};

pub const AcceptSubscriptionRequestOutput = struct {
    /// The timestamp that specifies when the subscription request was accepted.
    created_at: i64,

    /// Specifies the Amazon DataZone user that accepted the specified subscription
    /// request.
    created_by: []const u8,

    /// Specifies the reason for accepting the subscription request.
    decision_comment: ?[]const u8 = null,

    /// The unique identifier of the Amazon DataZone domain where the specified
    /// subscription request was accepted.
    domain_id: []const u8,

    /// The ID of the existing subscription.
    existing_subscription_id: ?[]const u8 = null,

    /// The identifier of the subscription request.
    id: []const u8,

    /// The metadata form in the subscription request.
    metadata_forms: ?[]const FormOutput = null,

    /// Specifies the reason for requesting a subscription to the asset.
    request_reason: []const u8,

    /// Specifes the ID of the Amazon DataZone user who reviewed the subscription
    /// request.
    reviewer_id: ?[]const u8 = null,

    /// Specifies the status of the subscription request.
    status: SubscriptionRequestStatus,

    /// Specifies the asset for which the subscription request was created.
    subscribed_listings: ?[]const SubscribedListing = null,

    /// Specifies the Amazon DataZone users who are subscribed to the asset
    /// specified in the subscription request.
    subscribed_principals: ?[]const SubscribedPrincipal = null,

    /// Specifies the timestamp when subscription request was updated.
    updated_at: i64,

    /// Specifies the Amazon DataZone user who updated the subscription request.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .decision_comment = "decisionComment",
        .domain_id = "domainId",
        .existing_subscription_id = "existingSubscriptionId",
        .id = "id",
        .metadata_forms = "metadataForms",
        .request_reason = "requestReason",
        .reviewer_id = "reviewerId",
        .status = "status",
        .subscribed_listings = "subscribedListings",
        .subscribed_principals = "subscribedPrincipals",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AcceptSubscriptionRequestInput, options: CallOptions) !AcceptSubscriptionRequestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AcceptSubscriptionRequestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/subscription-requests/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/accept");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.asset_permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assetPermissions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.asset_scopes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assetScopes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.decision_comment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"decisionComment\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AcceptSubscriptionRequestOutput {
    var result: AcceptSubscriptionRequestOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AcceptSubscriptionRequestOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
