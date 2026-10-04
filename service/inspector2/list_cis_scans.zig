const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListCisScansDetailLevel = @import("list_cis_scans_detail_level.zig").ListCisScansDetailLevel;
const ListCisScansFilterCriteria = @import("list_cis_scans_filter_criteria.zig").ListCisScansFilterCriteria;
const ListCisScansSortBy = @import("list_cis_scans_sort_by.zig").ListCisScansSortBy;
const CisSortOrder = @import("cis_sort_order.zig").CisSortOrder;
const CisScan = @import("cis_scan.zig").CisScan;

pub const ListCisScansInput = struct {
    /// The detail applied to the CIS scan.
    detail_level: ?ListCisScansDetailLevel = null,

    /// The CIS scan filter criteria.
    filter_criteria: ?ListCisScansFilterCriteria = null,

    /// The maximum number of results to be returned.
    max_results: ?i32 = null,

    /// The pagination token from a previous request that's used to retrieve the
    /// next page of
    /// results.
    next_token: ?[]const u8 = null,

    /// The CIS scans sort by order.
    sort_by: ?ListCisScansSortBy = null,

    /// The CIS scans sort order.
    sort_order: ?CisSortOrder = null,

    pub const json_field_names = .{
        .detail_level = "detailLevel",
        .filter_criteria = "filterCriteria",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};

pub const ListCisScansOutput = struct {
    /// The pagination token from a previous request that's used to retrieve the
    /// next page of
    /// results.
    next_token: ?[]const u8 = null,

    /// The CIS scans.
    scans: ?[]const CisScan = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .scans = "scans",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCisScansInput, options: CallOptions) !ListCisScansOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCisScansInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/cis/scan/list";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.detail_level) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"detailLevel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filter_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filterCriteria\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortBy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_order) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortOrder\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCisScansOutput {
    const result: ListCisScansOutput = try aws.json.parseJsonObject(
        ListCisScansOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
