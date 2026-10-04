const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DistributionTenantAssociationFilter = @import("distribution_tenant_association_filter.zig").DistributionTenantAssociationFilter;
const DistributionTenantSummary = @import("distribution_tenant_summary.zig").DistributionTenantSummary;
const serde = @import("serde.zig");

pub const ListDistributionTenantsInput = struct {
    association_filter: ?DistributionTenantAssociationFilter = null,

    /// The marker for the next set of results.
    marker: ?[]const u8 = null,

    /// The maximum number of distribution tenants to return.
    max_items: ?i32 = null,
};

pub const ListDistributionTenantsOutput = struct {
    /// The list of distribution tenants that you retrieved.
    distribution_tenant_list: ?[]const DistributionTenantSummary = null,

    /// A token used for pagination of results returned in the response. You can use
    /// the token from the previous request to define where the current request
    /// should begin.
    next_marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDistributionTenantsInput, options: CallOptions) !ListDistributionTenantsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDistributionTenantsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2020-05-31/distribution-tenants";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<ListDistributionTenantsRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    if (input.association_filter) |v| {
        try body_buf.appendSlice(allocator, "<AssociationFilter>");
        try serde.serializeDistributionTenantAssociationFilter(allocator, &body_buf, v);
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
    try body_buf.appendSlice(allocator, "</ListDistributionTenantsRequest>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDistributionTenantsOutput {
    var result: ListDistributionTenantsOutput = .{};
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
                if (std.mem.eql(u8, e.local, "DistributionTenantList")) {
                    result.distribution_tenant_list = try serde.deserializeDistributionTenantList(allocator, &reader, "DistributionTenantSummary");
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
