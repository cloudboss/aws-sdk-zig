const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReservedNodeOffering = @import("reserved_node_offering.zig").ReservedNodeOffering;
const serde = @import("serde.zig");

pub const GetReservedNodeExchangeOfferingsInput = struct {
    /// A value that indicates the starting point for the next set of
    /// ReservedNodeOfferings.
    marker: ?[]const u8 = null,

    /// An integer setting the maximum number of ReservedNodeOfferings to
    /// retrieve.
    max_records: ?i32 = null,

    /// A string representing the node identifier for the DC1 Reserved Node to be
    /// exchanged.
    reserved_node_id: []const u8,
};

pub const GetReservedNodeExchangeOfferingsOutput = struct {
    /// An optional parameter that specifies the starting point for returning a set
    /// of
    /// response records. When the results of a `GetReservedNodeExchangeOfferings`
    /// request exceed the value specified in MaxRecords, Amazon Redshift returns a
    /// value in the
    /// marker field of the response. You can retrieve the next set of response
    /// records by
    /// providing the returned marker value in the marker parameter and retrying the
    /// request.
    marker: ?[]const u8 = null,

    /// Returns an array of ReservedNodeOffering objects.
    reserved_node_offerings: ?[]const ReservedNodeOffering = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReservedNodeExchangeOfferingsInput, options: CallOptions) !GetReservedNodeExchangeOfferingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetReservedNodeExchangeOfferingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetReservedNodeExchangeOfferings&Version=2012-12-01");
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&ReservedNodeId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.reserved_node_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetReservedNodeExchangeOfferingsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetReservedNodeExchangeOfferingsResult")) break;
            },
            else => {},
        }
    }

    var result: GetReservedNodeExchangeOfferingsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReservedNodeOfferings")) {
                    result.reserved_node_offerings = try serde.deserializeReservedNodeOfferingList(allocator, &reader, "ReservedNodeOffering");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
