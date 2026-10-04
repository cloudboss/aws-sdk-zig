const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChangeBatch = @import("change_batch.zig").ChangeBatch;
const ChangeInfo = @import("change_info.zig").ChangeInfo;
const serde = @import("serde.zig");

pub const ChangeResourceRecordSetsInput = struct {
    /// A complex type that contains an optional comment and the `Changes`
    /// element.
    change_batch: ChangeBatch,

    /// The ID of the hosted zone that contains the resource record sets that you
    /// want to
    /// change.
    hosted_zone_id: []const u8,
};

pub const ChangeResourceRecordSetsOutput = struct {
    /// A complex type that contains information about changes made to your hosted
    /// zone.
    ///
    /// This element contains an ID that you use when performing a
    /// [GetChange](https://docs.aws.amazon.com/Route53/latest/APIReference/API_GetChange.html) action to get
    /// detailed information about the change.
    change_info: ?ChangeInfo = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ChangeResourceRecordSetsInput, options: CallOptions) !ChangeResourceRecordSetsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ChangeResourceRecordSetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2013-04-01/hostedzone/");
    try path_buf.appendSlice(allocator, input.hosted_zone_id);
    try path_buf.appendSlice(allocator, "/rrset");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<ChangeResourceRecordSetsRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\">");
    try body_buf.appendSlice(allocator, "<ChangeBatch>");
    try serde.serializeChangeBatch(allocator, &body_buf, input.change_batch);
    try body_buf.appendSlice(allocator, "</ChangeBatch>");
    try body_buf.appendSlice(allocator, "</ChangeResourceRecordSetsRequest>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ChangeResourceRecordSetsOutput {
    var result: ChangeResourceRecordSetsOutput = undefined;
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
                if (std.mem.eql(u8, e.local, "ChangeInfo")) {
                    result.change_info = try serde.deserializeChangeInfo(allocator, &reader);
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
