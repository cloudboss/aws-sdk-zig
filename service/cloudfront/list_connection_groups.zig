const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectionGroupAssociationFilter = @import("connection_group_association_filter.zig").ConnectionGroupAssociationFilter;
const ConnectionGroupSummary = @import("connection_group_summary.zig").ConnectionGroupSummary;
const serde = @import("serde.zig");

pub const ListConnectionGroupsInput = struct {
    /// Filter by associated Anycast IP list ID.
    association_filter: ?ConnectionGroupAssociationFilter = null,

    /// The marker for the next set of connection groups to retrieve.
    marker: ?[]const u8 = null,

    /// The maximum number of connection groups to return.
    max_items: ?i32 = null,
};

pub const ListConnectionGroupsOutput = struct {
    /// The list of connection groups that you retrieved.
    connection_groups: ?[]const ConnectionGroupSummary = null,

    /// A token used for pagination of results returned in the response. You can use
    /// the token from the previous request to define where the current request
    /// should begin.
    next_marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConnectionGroupsInput, options: CallOptions) !ListConnectionGroupsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListConnectionGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2020-05-31/connection-groups";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<ListConnectionGroupsRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    if (input.association_filter) |v| {
        try body_buf.appendSlice(allocator, "<AssociationFilter>");
        try serde.serializeConnectionGroupAssociationFilter(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</AssociationFilter>");
    }
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
    try body_buf.appendSlice(allocator, "</ListConnectionGroupsRequest>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConnectionGroupsOutput {
    var result: ListConnectionGroupsOutput = .{};
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
                if (std.mem.eql(u8, e.local, "ConnectionGroups")) {
                    result.connection_groups = try serde.deserializeConnectionGroupSummaryList(allocator, &reader, "ConnectionGroupSummary");
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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
