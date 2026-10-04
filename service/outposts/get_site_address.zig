const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AddressType = @import("address_type.zig").AddressType;
const Address = @import("address.zig").Address;

pub const GetSiteAddressInput = struct {
    /// The type of the address you request.
    address_type: AddressType,

    /// The ID or the Amazon Resource Name (ARN) of the site.
    site_id: []const u8,

    pub const json_field_names = .{
        .address_type = "AddressType",
        .site_id = "SiteId",
    };
};

pub const GetSiteAddressOutput = struct {
    /// Information about the address.
    address: ?Address = null,

    /// The type of the address you receive.
    address_type: ?AddressType = null,

    site_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .address = "Address",
        .address_type = "AddressType",
        .site_id = "SiteId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSiteAddressInput, options: CallOptions) !GetSiteAddressOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "outposts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSiteAddressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("outposts", "Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sites/");
    try path_buf.appendSlice(allocator, input.site_id);
    try path_buf.appendSlice(allocator, "/address");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "AddressType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.address_type.wireName());
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSiteAddressOutput {
    var result: GetSiteAddressOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSiteAddressOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
