const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CisScanResultDetailsFilterCriteria = @import("cis_scan_result_details_filter_criteria.zig").CisScanResultDetailsFilterCriteria;
const CisScanResultDetailsSortBy = @import("cis_scan_result_details_sort_by.zig").CisScanResultDetailsSortBy;
const CisSortOrder = @import("cis_sort_order.zig").CisSortOrder;
const CisScanResultDetails = @import("cis_scan_result_details.zig").CisScanResultDetails;

pub const GetCisScanResultDetailsInput = struct {
    /// The account ID.
    account_id: []const u8,

    /// The filter criteria.
    filter_criteria: ?CisScanResultDetailsFilterCriteria = null,

    /// The maximum number of CIS scan result details to be returned in a single
    /// page of
    /// results.
    max_results: ?i32 = null,

    /// The pagination token from a previous request that's used to retrieve the
    /// next page of
    /// results.
    next_token: ?[]const u8 = null,

    /// The scan ARN.
    scan_arn: []const u8,

    /// The sort by order.
    sort_by: ?CisScanResultDetailsSortBy = null,

    /// The sort order.
    sort_order: ?CisSortOrder = null,

    /// The target resource ID.
    target_resource_id: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .filter_criteria = "filterCriteria",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .scan_arn = "scanArn",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
        .target_resource_id = "targetResourceId",
    };
};

pub const GetCisScanResultDetailsOutput = struct {
    /// The pagination token from a previous request that's used to retrieve the
    /// next page of
    /// results.
    next_token: ?[]const u8 = null,

    /// The scan result details.
    scan_result_details: ?[]const CisScanResultDetails = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .scan_result_details = "scanResultDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCisScanResultDetailsInput, options: CallOptions) !GetCisScanResultDetailsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCisScanResultDetailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/cis/scan-result/details/get";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"accountId\":");
    try aws.json.writeValue(@TypeOf(input.account_id), input.account_id, allocator, &body_buf);
    has_prev = true;
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"scanArn\":");
    try aws.json.writeValue(@TypeOf(input.scan_arn), input.scan_arn, allocator, &body_buf);
    has_prev = true;
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetResourceId\":");
    try aws.json.writeValue(@TypeOf(input.target_resource_id), input.target_resource_id, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCisScanResultDetailsOutput {
    const result: GetCisScanResultDetailsOutput = try aws.json.parseJsonObject(
        GetCisScanResultDetailsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
