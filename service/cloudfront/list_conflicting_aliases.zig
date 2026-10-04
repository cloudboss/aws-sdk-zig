const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConflictingAliasesList = @import("conflicting_aliases_list.zig").ConflictingAliasesList;
const serde = @import("serde.zig");

pub const ListConflictingAliasesInput = struct {
    /// The alias (also called a CNAME) to search for conflicting aliases.
    alias: []const u8,

    /// The ID of a standard distribution in your account that has an attached TLS
    /// certificate that includes the provided alias.
    distribution_id: []const u8,

    /// Use this field when paginating results to indicate where to begin in the
    /// list of conflicting aliases. The response includes conflicting aliases in
    /// the list that occur after the marker. To get the next page of the list, set
    /// this field's value to the value of `NextMarker` from the current page's
    /// response.
    marker: ?[]const u8 = null,

    /// The maximum number of conflicting aliases that you want in the response.
    max_items: ?i32 = null,
};

pub const ListConflictingAliasesOutput = struct {
    /// A list of conflicting aliases.
    conflicting_aliases_list: ?ConflictingAliasesList = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConflictingAliasesInput, options: CallOptions) !ListConflictingAliasesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListConflictingAliasesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2020-05-31/conflicting-alias";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "Alias=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.alias);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "DistributionId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.distribution_id);
    query_has_prev = true;
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxItems=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConflictingAliasesOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: ListConflictingAliasesOutput = .{};

    return result;
}
