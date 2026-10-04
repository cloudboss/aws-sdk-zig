const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubscriptionStatus = @import("subscription_status.zig").SubscriptionStatus;
const SubscribedListing = @import("subscribed_listing.zig").SubscribedListing;
const SubscribedPrincipal = @import("subscribed_principal.zig").SubscribedPrincipal;

pub const CancelSubscriptionInput = struct {
    /// The unique identifier of the Amazon DataZone domain where the subscription
    /// request is being cancelled.
    domain_identifier: []const u8,

    /// The unique identifier of the subscription that is being cancelled.
    identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
    };
};

pub const CancelSubscriptionOutput = struct {
    /// The timestamp that specifies when the request to cancel the subscription was
    /// created.
    created_at: i64,

    /// Specifies the Amazon DataZone user who is cancelling the subscription.
    created_by: []const u8,

    /// The unique identifier of the Amazon DataZone domain where the subscription
    /// is being cancelled.
    domain_id: []const u8,

    /// The identifier of the subscription.
    id: []const u8,

    /// Specifies whether the permissions to the asset are retained after the
    /// subscription is cancelled.
    retain_permissions: ?bool = null,

    /// The status of the request to cancel the subscription.
    status: SubscriptionStatus,

    /// The asset to which a subscription is being cancelled.
    subscribed_listing: ?SubscribedListing = null,

    /// The Amazon DataZone user who is made a subscriber to the specified asset by
    /// the subscription that is being cancelled.
    subscribed_principal: ?SubscribedPrincipal = null,

    /// The unique ID of the subscripton request for the subscription that is being
    /// cancelled.
    subscription_request_id: ?[]const u8 = null,

    /// The timestamp that specifies when the subscription was cancelled.
    updated_at: i64,

    /// The Amazon DataZone user that cancelled the subscription.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .id = "id",
        .retain_permissions = "retainPermissions",
        .status = "status",
        .subscribed_listing = "subscribedListing",
        .subscribed_principal = "subscribedPrincipal",
        .subscription_request_id = "subscriptionRequestId",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelSubscriptionInput, options: CallOptions) !CancelSubscriptionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/subscriptions/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/cancel");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelSubscriptionOutput {
    var result: CancelSubscriptionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CancelSubscriptionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
