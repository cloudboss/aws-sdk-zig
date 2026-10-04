const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScanType = @import("scan_type.zig").ScanType;
const ResourceScanSummary = @import("resource_scan_summary.zig").ResourceScanSummary;
const serde = @import("serde.zig");

pub const ListResourceScansInput = struct {
    /// If the number of available results exceeds this maximum, the response
    /// includes a
    /// `NextToken` value that you can use for the `NextToken` parameter to
    /// get the next set of results. The default value is 10. The maximum value is
    /// 100.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// The scan type that you want to get summary information about. The default is
    /// `FULL`.
    scan_type_filter: ?ScanType = null,
};

pub const ListResourceScansOutput = struct {
    /// If the request doesn't return all the remaining results, `NextToken` is set
    /// to
    /// a token. To retrieve the next set of results, call `ListResourceScans` again
    /// and
    /// use that value for the `NextToken` parameter. If the request returns all
    /// results,
    /// `NextToken` is set to an empty string.
    next_token: ?[]const u8 = null,

    /// The list of scans returned.
    resource_scan_summaries: ?[]const ResourceScanSummary = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourceScansInput, options: CallOptions) !ListResourceScansOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourceScansInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListResourceScans&Version=2010-05-15");
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.scan_type_filter) |v| {
        try body_buf.appendSlice(allocator, "&ScanTypeFilter=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourceScansOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListResourceScansResult")) break;
            },
            else => {},
        }
    }

    var result: ListResourceScansOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceScanSummaries")) {
                    result.resource_scan_summaries = try serde.deserializeResourceScanSummaries(allocator, &reader, "member");
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
