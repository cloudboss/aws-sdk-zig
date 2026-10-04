const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CoverageFilterCriteria = @import("coverage_filter_criteria.zig").CoverageFilterCriteria;
const CoverageSortCriteria = @import("coverage_sort_criteria.zig").CoverageSortCriteria;
const CoverageResource = @import("coverage_resource.zig").CoverageResource;

pub const ListCoverageInput = struct {
    /// The unique ID of the detector whose coverage details you want to retrieve.
    ///
    /// To find the `detectorId` in the current Region, see the Settings page in the
    /// GuardDuty console, or run the
    /// [ListDetectors](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_ListDetectors.html) API.
    detector_id: []const u8,

    /// Represents the criteria used to filter the coverage details.
    filter_criteria: ?CoverageFilterCriteria = null,

    /// The maximum number of results to return in the response.
    max_results: ?i32 = null,

    /// A token to use for paginating results that are returned in the response. Set
    /// the value of this parameter to null for the first request to a list action.
    /// For subsequent calls, use the NextToken value returned from the previous
    /// request to continue listing results after the first page.
    next_token: ?[]const u8 = null,

    /// Represents the criteria used to sort the coverage details.
    sort_criteria: ?CoverageSortCriteria = null,

    pub const json_field_names = .{
        .detector_id = "DetectorId",
        .filter_criteria = "FilterCriteria",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_criteria = "SortCriteria",
    };
};

pub const ListCoverageOutput = struct {
    /// The pagination parameter to be used on the next list operation to retrieve
    /// more items.
    next_token: ?[]const u8 = null,

    /// A list of resources and their attributes providing cluster details.
    resources: ?[]const CoverageResource = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resources = "Resources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCoverageInput, options: CallOptions) !ListCoverageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "guardduty", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCoverageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/detector/");
    try path_buf.appendSlice(allocator, input.detector_id);
    try path_buf.appendSlice(allocator, "/coverage");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filter_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FilterCriteria\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SortCriteria\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCoverageOutput {
    const result: ListCoverageOutput = try aws.json.parseJsonObject(
        ListCoverageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
