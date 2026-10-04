const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DisplayOrder = @import("display_order.zig").DisplayOrder;

pub const GetPortalProductInput = struct {
    /// The portal product identifier.
    portal_product_id: []const u8,

    /// The account ID of the resource owner of the portal product.
    resource_owner_account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .portal_product_id = "PortalProductId",
        .resource_owner_account_id = "ResourceOwnerAccountId",
    };
};

pub const GetPortalProductOutput = struct {
    /// The description of a portal product.
    description: ?[]const u8 = null,

    /// The display name.
    display_name: ?[]const u8 = null,

    /// The display order.
    display_order: ?DisplayOrder = null,

    /// The timestamp when the portal product was last modified.
    last_modified: ?i64 = null,

    /// The ARN of the portal product.
    portal_product_arn: ?[]const u8 = null,

    /// The portal product identifier.
    portal_product_id: ?[]const u8 = null,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "Description",
        .display_name = "DisplayName",
        .display_order = "DisplayOrder",
        .last_modified = "LastModified",
        .portal_product_arn = "PortalProductArn",
        .portal_product_id = "PortalProductId",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPortalProductInput, options: CallOptions) !GetPortalProductOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPortalProductInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/portalproducts/");
    try path_buf.appendSlice(allocator, input.portal_product_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.resource_owner_account_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "resourceOwnerAccountId=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPortalProductOutput {
    const result: GetPortalProductOutput = try aws.json.parseJsonObject(
        GetPortalProductOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
