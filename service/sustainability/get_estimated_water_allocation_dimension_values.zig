const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Dimension = @import("dimension.zig").Dimension;
const TimePeriod = @import("time_period.zig").TimePeriod;
const DimensionEntry = @import("dimension_entry.zig").DimensionEntry;

pub const GetEstimatedWaterAllocationDimensionValuesInput = struct {
    /// The dimensions available for grouping estimated water allocation.
    dimensions: []const Dimension,

    /// The maximum number of results to return in a single call. Default is 1000.
    max_results: ?i32 = null,

    /// The pagination token specifying which page of results to return in the
    /// response. If no token is provided, the default page is the first page.
    next_token: ?[]const u8 = null,

    /// The date range for fetching the dimension values. The range must include the
    /// start date of a year for that year's data to be included in the response.
    time_period: TimePeriod,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .time_period = "TimePeriod",
    };
};

pub const GetEstimatedWaterAllocationDimensionValuesOutput = struct {
    /// The pagination token indicating there are additional pages available. You
    /// can use the token in a following request to fetch the next set of results.
    next_token: ?[]const u8 = null,

    /// The list of possible dimensions over which the allocation data is
    /// aggregated.
    results: ?[]const DimensionEntry = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .results = "Results",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEstimatedWaterAllocationDimensionValuesInput, options: CallOptions) !GetEstimatedWaterAllocationDimensionValuesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sustainability", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEstimatedWaterAllocationDimensionValuesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sustainability", "Sustainability", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/estimated-water-allocation-dimension-values";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Dimensions\":");
    try aws.json.writeValue(@TypeOf(input.dimensions), input.dimensions, allocator, &body_buf);
    has_prev = true;
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TimePeriod\":");
    try aws.json.writeValue(@TypeOf(input.time_period), input.time_period, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEstimatedWaterAllocationDimensionValuesOutput {
    const result: GetEstimatedWaterAllocationDimensionValuesOutput = try aws.json.parseJsonObject(
        GetEstimatedWaterAllocationDimensionValuesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
