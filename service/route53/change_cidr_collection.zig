const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CidrCollectionChange = @import("cidr_collection_change.zig").CidrCollectionChange;
const serde = @import("serde.zig");

pub const ChangeCidrCollectionInput = struct {
    /// Information about changes to a CIDR collection.
    changes: []const CidrCollectionChange,

    /// A sequential counter that Amazon Route 53 sets to 1 when you create a
    /// collection and increments it by 1 each time you update the collection.
    ///
    /// We recommend that you use `ListCidrCollection` to get the current value of
    /// `CollectionVersion` for the collection that you want to update, and then
    /// include that value with the change request. This prevents Route 53 from
    /// overwriting an intervening update:
    ///
    /// * If the value in the request matches the value of
    /// `CollectionVersion` in the collection, Route 53 updates
    /// the collection.
    ///
    /// * If the value of `CollectionVersion` in the collection is greater
    /// than the value in the request, the collection was changed after you got the
    /// version number. Route 53 does not update the collection, and it
    /// returns a `CidrCollectionVersionMismatch` error.
    collection_version: ?i64 = null,

    /// The UUID of the CIDR collection to update.
    id: []const u8,
};

pub const ChangeCidrCollectionOutput = struct {
    /// The ID that is returned by `ChangeCidrCollection`. You can use it as input
    /// to
    /// `GetChange` to see if a CIDR collection change has propagated or
    /// not.
    id: []const u8,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ChangeCidrCollectionInput, options: CallOptions) !ChangeCidrCollectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ChangeCidrCollectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2013-04-01/cidrcollection/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<ChangeCidrCollectionRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\">");
    try body_buf.appendSlice(allocator, "<Changes>");
    try serde.serializeCidrCollectionChanges(allocator, &body_buf, input.changes, "member");
    try body_buf.appendSlice(allocator, "</Changes>");
    if (input.collection_version) |v| {
        try body_buf.appendSlice(allocator, "<CollectionVersion>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try body_buf.appendSlice(allocator, num_str);
        }
        try body_buf.appendSlice(allocator, "</CollectionVersion>");
    }
    try body_buf.appendSlice(allocator, "</ChangeCidrCollectionRequest>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ChangeCidrCollectionOutput {
    var result: ChangeCidrCollectionOutput = undefined;
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
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
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
