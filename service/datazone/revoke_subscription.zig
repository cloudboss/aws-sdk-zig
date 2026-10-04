const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubscriptionStatus = @import("subscription_status.zig").SubscriptionStatus;
const SubscribedListing = @import("subscribed_listing.zig").SubscribedListing;
const SubscribedPrincipal = @import("subscribed_principal.zig").SubscribedPrincipal;

pub const RevokeSubscriptionInput = struct {
    /// The identifier of the Amazon DataZone domain where you want to revoke a
    /// subscription.
    domain_identifier: []const u8,

    /// The identifier of the revoked subscription.
    identifier: []const u8,

    /// Specifies whether permissions are retained when the subscription is revoked.
    retain_permissions: ?bool = null,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
        .retain_permissions = "retainPermissions",
    };
};

pub const RevokeSubscriptionOutput = struct {
    /// The timestamp of when the subscription was revoked.
    created_at: i64,

    /// The identifier of the user who revoked the subscription.
    created_by: []const u8,

    /// The identifier of the Amazon DataZone domain where you want to revoke a
    /// subscription.
    domain_id: []const u8,

    /// The identifier of the revoked subscription.
    id: []const u8,

    /// Specifies whether permissions are retained when the subscription is revoked.
    retain_permissions: ?bool = null,

    /// The status of the revoked subscription.
    status: SubscriptionStatus,

    /// The subscribed listing of the revoked subscription.
    subscribed_listing: ?SubscribedListing = null,

    /// The subscribed principal of the revoked subscription.
    subscribed_principal: ?SubscribedPrincipal = null,

    /// The identifier of the subscription request for the revoked subscription.
    subscription_request_id: ?[]const u8 = null,

    /// The timestamp of when the subscription was revoked.
    updated_at: i64,

    /// The Amazon DataZone user who revoked the subscription.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RevokeSubscriptionInput, options: CallOptions) !RevokeSubscriptionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RevokeSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/subscriptions/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/revoke");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.retain_permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"retainPermissions\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RevokeSubscriptionOutput {
    var result: RevokeSubscriptionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RevokeSubscriptionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
