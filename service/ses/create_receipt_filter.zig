const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReceiptFilter = @import("receipt_filter.zig").ReceiptFilter;
const serde = @import("serde.zig");

pub const CreateReceiptFilterInput = struct {
    /// A data structure that describes the IP address filter to create, which
    /// consists of a
    /// name, an IP address range, and whether to allow or block mail from it.
    filter: ReceiptFilter,
};

pub const CreateReceiptFilterOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateReceiptFilterInput, options: CallOptions) !CreateReceiptFilterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateReceiptFilterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateReceiptFilter&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&Filter.IpFilter.Cidr=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.filter.ip_filter.cidr);
    try body_buf.appendSlice(allocator, "&Filter.IpFilter.Policy=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.filter.ip_filter.policy.wireName());
    try body_buf.appendSlice(allocator, "&Filter.Name=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.filter.name);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateReceiptFilterOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: CreateReceiptFilterOutput = .{};

    return result;
}
