const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainUnitSummary = @import("domain_unit_summary.zig").DomainUnitSummary;

pub const ListDomainUnitsForParentInput = struct {
    /// The ID of the domain in which you want to list domain units for a parent
    /// domain unit.
    domain_identifier: []const u8,

    /// The maximum number of domain units to return in a single call to
    /// ListDomainUnitsForParent. When the number of domain units to be listed is
    /// greater than the value of MaxResults, the response contains a NextToken
    /// value that you can use in a subsequent call to ListDomainUnitsForParent to
    /// list the next set of domain units.
    max_results: ?i32 = null,

    /// When the number of domain units is greater than the default value for the
    /// MaxResults parameter, or if you explicitly specify a value for MaxResults
    /// that is less than the number of domain units, the response includes a
    /// pagination token named NextToken. You can specify this NextToken value in a
    /// subsequent call to ListDomainUnitsForParent to list the next set of domain
    /// units.
    next_token: ?[]const u8 = null,

    /// The ID of the parent domain unit.
    parent_domain_unit_identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .parent_domain_unit_identifier = "parentDomainUnitIdentifier",
    };
};

pub const ListDomainUnitsForParentOutput = struct {
    /// The results returned by this action.
    items: ?[]const DomainUnitSummary = null,

    /// When the number of domain units is greater than the default value for the
    /// MaxResults parameter, or if you explicitly specify a value for MaxResults
    /// that is less than the number of domain units, the response includes a
    /// pagination token named NextToken. You can specify this NextToken value in a
    /// subsequent call to ListDomainUnitsForParent to list the next set of domain
    /// units.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDomainUnitsForParentInput, options: CallOptions) !ListDomainUnitsForParentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDomainUnitsForParentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/domain-units");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "parentDomainUnitIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.parent_domain_unit_identifier);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDomainUnitsForParentOutput {
    var result: ListDomainUnitsForParentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListDomainUnitsForParentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
