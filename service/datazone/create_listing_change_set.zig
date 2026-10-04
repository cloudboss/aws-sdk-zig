const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChangeAction = @import("change_action.zig").ChangeAction;
const EntityType = @import("entity_type.zig").EntityType;
const ListingStatus = @import("listing_status.zig").ListingStatus;

pub const CreateListingChangeSetInput = struct {
    /// Specifies whether to publish or unpublish a listing.
    action: ChangeAction,

    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain.
    domain_identifier: []const u8,

    /// The ID of the asset.
    entity_identifier: []const u8,

    /// The revision of an asset.
    entity_revision: ?[]const u8 = null,

    /// The type of an entity.
    entity_type: EntityType,

    pub const json_field_names = .{
        .action = "action",
        .client_token = "clientToken",
        .domain_identifier = "domainIdentifier",
        .entity_identifier = "entityIdentifier",
        .entity_revision = "entityRevision",
        .entity_type = "entityType",
    };
};

pub const CreateListingChangeSetOutput = struct {
    /// The ID of the listing (a record of an asset at a given time).
    listing_id: []const u8,

    /// The revision of a listing.
    listing_revision: []const u8,

    /// Specifies the status of the listing.
    status: ListingStatus,

    pub const json_field_names = .{
        .listing_id = "listingId",
        .listing_revision = "listingRevision",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateListingChangeSetInput, options: CallOptions) !CreateListingChangeSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateListingChangeSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/listings/change-set");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"action\":");
    try aws.json.writeValue(@TypeOf(input.action), input.action, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"entityIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.entity_identifier), input.entity_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.entity_revision) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"entityRevision\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"entityType\":");
    try aws.json.writeValue(@TypeOf(input.entity_type), input.entity_type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateListingChangeSetOutput {
    const result: CreateListingChangeSetOutput = try aws.json.parseJsonObject(
        CreateListingChangeSetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
