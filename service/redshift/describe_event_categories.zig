const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventCategoriesMap = @import("event_categories_map.zig").EventCategoriesMap;
const serde = @import("serde.zig");

pub const DescribeEventCategoriesInput = struct {
    /// The source type, such as cluster or parameter group, to which the described
    /// event
    /// categories apply.
    ///
    /// Valid values: cluster, cluster-snapshot, cluster-parameter-group,
    /// cluster-security-group, and scheduled-action.
    source_type: ?[]const u8 = null,
};

pub const DescribeEventCategoriesOutput = struct {
    /// A list of event categories descriptions.
    event_categories_map_list: ?[]const EventCategoriesMap = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEventCategoriesInput, options: CallOptions) !DescribeEventCategoriesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEventCategoriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeEventCategories&Version=2012-12-01");
    if (input.source_type) |v| {
        try body_buf.appendSlice(allocator, "&SourceType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEventCategoriesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeEventCategoriesResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeEventCategoriesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EventCategoriesMapList")) {
                    result.event_categories_map_list = try serde.deserializeEventCategoriesMapList(allocator, &reader, "EventCategoriesMap");
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
