const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RasterDataCollectionQueryWithBandFilterInput = @import("raster_data_collection_query_with_band_filter_input.zig").RasterDataCollectionQueryWithBandFilterInput;
const ItemSource = @import("item_source.zig").ItemSource;

pub const SearchRasterDataCollectionInput = struct {
    /// The Amazon Resource Name (ARN) of the raster data collection.
    arn: []const u8,

    /// If the previous response was truncated, you receive this token.
    /// Use it in your next request to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// RasterDataCollectionQuery consisting of
    /// [AreaOfInterest(AOI)](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_geospatial_AreaOfInterest.html), [PropertyFilters](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_geospatial_PropertyFilter.html) and
    /// [TimeRangeFilterInput](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_geospatial_TimeRangeFilterInput.html) used in [SearchRasterDataCollection](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_geospatial_SearchRasterDataCollection.html).
    raster_data_collection_query: RasterDataCollectionQueryWithBandFilterInput,

    pub const json_field_names = .{
        .arn = "Arn",
        .next_token = "NextToken",
        .raster_data_collection_query = "RasterDataCollectionQuery",
    };
};

pub const SearchRasterDataCollectionOutput = struct {
    /// Approximate number of results in the response.
    approximate_result_count: i32,

    /// List of items matching the Raster DataCollectionQuery.
    items: ?[]const ItemSource = null,

    /// If the previous response was truncated, you receive this token.
    /// Use it in your next request to receive the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .approximate_result_count = "ApproximateResultCount",
        .items = "Items",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchRasterDataCollectionInput, options: CallOptions) !SearchRasterDataCollectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker-geospatial", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchRasterDataCollectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker-geospatial", "SageMaker Geospatial", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/search-raster-data-collection";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, allocator, &body_buf);
    has_prev = true;
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RasterDataCollectionQuery\":");
    try aws.json.writeValue(@TypeOf(input.raster_data_collection_query), input.raster_data_collection_query, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchRasterDataCollectionOutput {
    const result: SearchRasterDataCollectionOutput = try aws.json.parseJsonObject(
        SearchRasterDataCollectionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
