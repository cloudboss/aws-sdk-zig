const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FormOutput = @import("form_output.zig").FormOutput;
const SubscriptionRequestStatus = @import("subscription_request_status.zig").SubscriptionRequestStatus;
const SubscribedListing = @import("subscribed_listing.zig").SubscribedListing;
const SubscribedPrincipal = @import("subscribed_principal.zig").SubscribedPrincipal;

pub const GetSubscriptionRequestDetailsInput = struct {
    /// The identifier of the Amazon DataZone domain in which to get the
    /// subscription request details.
    domain_identifier: []const u8,

    /// The identifier of the subscription request the details of which to get.
    identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
    };
};

pub const GetSubscriptionRequestDetailsOutput = struct {
    /// The timestamp of when the specified subscription request was created.
    created_at: i64,

    /// The Amazon DataZone user who created the subscription request.
    created_by: []const u8,

    /// The decision comment of the subscription request.
    decision_comment: ?[]const u8 = null,

    /// The Amazon DataZone domain of the subscription request.
    domain_id: []const u8,

    /// The ID of the existing subscription.
    existing_subscription_id: ?[]const u8 = null,

    /// The identifier of the subscription request.
    id: []const u8,

    /// The metadata forms included in the subscription request.
    metadata_forms: ?[]const FormOutput = null,

    /// The reason for the subscription request.
    request_reason: []const u8,

    /// The identifier of the Amazon DataZone user who reviewed the subscription
    /// request.
    reviewer_id: ?[]const u8 = null,

    /// The status of the subscription request.
    status: SubscriptionRequestStatus,

    /// The subscribed listings in the subscription request.
    subscribed_listings: ?[]const SubscribedListing = null,

    /// The subscribed principals in the subscription request.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSubscriptionRequestDetailsInput, options: CallOptions) !GetSubscriptionRequestDetailsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSubscriptionRequestDetailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/subscription-requests/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSubscriptionRequestDetailsOutput {
    const result: GetSubscriptionRequestDetailsOutput = try aws.json.parseJsonObject(
        GetSubscriptionRequestDetailsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
