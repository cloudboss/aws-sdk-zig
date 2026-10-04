const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetPermission = @import("asset_permission.zig").AssetPermission;
const AcceptedAssetScope = @import("accepted_asset_scope.zig").AcceptedAssetScope;
const FormInput = @import("form_input.zig").FormInput;
const SubscribedListingInput = @import("subscribed_listing_input.zig").SubscribedListingInput;
const SubscribedPrincipalInput = @import("subscribed_principal_input.zig").SubscribedPrincipalInput;
const FormOutput = @import("form_output.zig").FormOutput;
const SubscriptionRequestStatus = @import("subscription_request_status.zig").SubscriptionRequestStatus;
const SubscribedListing = @import("subscribed_listing.zig").SubscribedListing;
const SubscribedPrincipal = @import("subscribed_principal.zig").SubscribedPrincipal;

pub const CreateSubscriptionRequestInput = struct {
    /// The asset permissions of the subscription request.
    asset_permissions: ?[]const AssetPermission = null,

    /// The asset scopes of the subscription request.
    asset_scopes: ?[]const AcceptedAssetScope = null,

    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which the subscription request is
    /// created.
    domain_identifier: []const u8,

    /// The metadata form included in the subscription request.
    metadata_forms: ?[]const FormInput = null,

    /// The reason for the subscription request.
    request_reason: []const u8,

    /// The published asset for which the subscription grant is to be created.
    subscribed_listings: []const SubscribedListingInput,

    /// The Amazon DataZone principals for whom the subscription request is created.
    subscribed_principals: []const SubscribedPrincipalInput,

    pub const json_field_names = .{
        .asset_permissions = "assetPermissions",
        .asset_scopes = "assetScopes",
        .client_token = "clientToken",
        .domain_identifier = "domainIdentifier",
        .metadata_forms = "metadataForms",
        .request_reason = "requestReason",
        .subscribed_listings = "subscribedListings",
        .subscribed_principals = "subscribedPrincipals",
    };
};

pub const CreateSubscriptionRequestOutput = struct {
    /// A timestamp of when the subscription request is created.
    created_at: i64,

    /// The Amazon DataZone user who created the subscription request.
    created_by: []const u8,

    /// The decision comment of the subscription request.
    decision_comment: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in whcih the subscription request is
    /// created.
    domain_id: []const u8,

    /// The ID of the existing subscription.
    existing_subscription_id: ?[]const u8 = null,

    /// The ID of the subscription request.
    id: []const u8,

    /// The metadata form included in the subscription request.
    metadata_forms: ?[]const FormOutput = null,

    /// The reason for the subscription request.
    request_reason: []const u8,

    /// The ID of the reviewer of the subscription request.
    reviewer_id: ?[]const u8 = null,

    /// The status of the subscription request.
    status: SubscriptionRequestStatus,

    /// The published asset for which the subscription grant is to be created.
    subscribed_listings: ?[]const SubscribedListing = null,

    /// The subscribed principals of the subscription request.
    subscribed_principals: ?[]const SubscribedPrincipal = null,

    /// The timestamp of when the subscription request was updated.
    updated_at: i64,

    /// The Amazon DataZone user who updated the subscription request.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSubscriptionRequestInput, options: CallOptions) !CreateSubscriptionRequestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSubscriptionRequestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/subscription-requests");
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
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metadata_forms) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metadataForms\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"requestReason\":");
    try aws.json.writeValue(@TypeOf(input.request_reason), input.request_reason, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"subscribedListings\":");
    try aws.json.writeValue(@TypeOf(input.subscribed_listings), input.subscribed_listings, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"subscribedPrincipals\":");
    try aws.json.writeValue(@TypeOf(input.subscribed_principals), input.subscribed_principals, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSubscriptionRequestOutput {
    const result: CreateSubscriptionRequestOutput = try aws.json.parseJsonObject(
        CreateSubscriptionRequestOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
