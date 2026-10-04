const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrustStoreSummary = @import("trust_store_summary.zig").TrustStoreSummary;
const serde = @import("serde.zig");

pub const ListTrustStoresInput = struct {
    /// Use this field when paginating results to indicate where to begin in your
    /// list. The response includes items in the list that occur after the marker.
    /// To get the next page of the list, set this field's value to the value of
    /// `NextMarker` from the current page's response.
    marker: ?[]const u8 = null,

    /// The maximum number of trust stores that you want returned in the response.
    max_items: ?i32 = null,
};

pub const ListTrustStoresOutput = struct {
    /// Indicates the next page of trust stores. To get the next page of the list,
    /// use this value in the `Marker` field of your request.
    next_marker: ?[]const u8 = null,

    /// The trust store list.
    trust_store_list: ?[]const TrustStoreSummary = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTrustStoresInput, options: CallOptions) !ListTrustStoresOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudfront", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTrustStoresInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2020-05-31/trust-stores";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<ListTrustStoresRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "<Marker>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</Marker>");
    }
    if (input.max_items) |v| {
        try body_buf.appendSlice(allocator, "<MaxItems>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try body_buf.appendSlice(allocator, num_str);
        }
        try body_buf.appendSlice(allocator, "</MaxItems>");
    }
    try body_buf.appendSlice(allocator, "</ListTrustStoresRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTrustStoresOutput {
    var result: ListTrustStoresOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrustStoreList")) {
                    result.trust_store_list = try serde.deserializeTrustStoreList(allocator, &reader, "TrustStoreSummary");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}
