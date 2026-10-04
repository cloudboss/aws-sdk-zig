const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListingItem = @import("listing_item.zig").ListingItem;
const ListingStatus = @import("listing_status.zig").ListingStatus;

pub const GetListingInput = struct {
    /// The ID of the Amazon DataZone domain.
    domain_identifier: []const u8,

    /// The ID of the listing.
    identifier: []const u8,

    /// The revision of the listing.
    listing_revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
        .listing_revision = "listingRevision",
    };
};

pub const GetListingOutput = struct {
    /// The timestamp of when the listing was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created the listing.
    created_by: ?[]const u8 = null,

    /// The description of the listing.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain.
    domain_id: []const u8,

    /// The ID of the listing.
    id: []const u8,

    /// The details of a listing.
    item: ?ListingItem = null,

    /// The revision of a listing.
    listing_revision: []const u8,

    /// The name of the listing.
    name: ?[]const u8 = null,

    /// The status of the listing.
    status: ?ListingStatus = null,

    /// The timestamp of when the listing was updated.
    updated_at: ?i64 = null,

    /// The Amazon DataZone user who updated the listing.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .id = "id",
        .item = "item",
        .listing_revision = "listingRevision",
        .name = "name",
        .status = "status",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetListingInput, options: CallOptions) !GetListingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetListingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/listings/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.listing_revision) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "listingRevision=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetListingOutput {
    var result: GetListingOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetListingOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
