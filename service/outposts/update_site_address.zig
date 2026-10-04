const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Address = @import("address.zig").Address;
const AddressType = @import("address_type.zig").AddressType;

pub const UpdateSiteAddressInput = struct {
    /// The address for the site.
    address: Address,

    /// The type of the address.
    address_type: AddressType,

    /// The ID or the Amazon Resource Name (ARN) of the site.
    site_id: []const u8,

    pub const json_field_names = .{
        .address = "Address",
        .address_type = "AddressType",
        .site_id = "SiteId",
    };
};

pub const UpdateSiteAddressOutput = struct {
    /// Information about an address.
    address: ?Address = null,

    /// The type of the address.
    address_type: ?AddressType = null,

    pub const json_field_names = .{
        .address = "Address",
        .address_type = "AddressType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSiteAddressInput, options: CallOptions) !UpdateSiteAddressOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSiteAddressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("outposts", "Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sites/");
    try path_buf.appendSlice(allocator, input.site_id);
    try path_buf.appendSlice(allocator, "/address");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Address\":");
    try aws.json.writeValue(@TypeOf(input.address), input.address, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AddressType\":");
    try aws.json.writeValue(@TypeOf(input.address_type), input.address_type, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSiteAddressOutput {
    const result: UpdateSiteAddressOutput = try aws.json.parseJsonObject(
        UpdateSiteAddressOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
