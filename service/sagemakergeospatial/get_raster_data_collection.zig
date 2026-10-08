const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const DataCollectionType = @import("data_collection_type.zig").DataCollectionType;

pub const GetRasterDataCollectionInput = struct {
    /// The Amazon Resource Name (ARN) of the raster data collection.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub const GetRasterDataCollectionOutput = struct {
    /// The Amazon Resource Name (ARN) of the raster data collection.
    arn: []const u8,

    /// A description of the raster data collection.
    description: []const u8,

    /// The URL of the description page.
    description_page_url: []const u8,

    /// The list of image source bands in the raster data collection.
    image_source_bands: ?[]const []const u8 = null,

    /// The name of the raster data collection.
    name: []const u8,

    /// The filters supported by the raster data collection.
    supported_filters: ?[]const Filter = null,

    /// Each tag consists of a key and a value.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The raster data collection type.
    type: DataCollectionType,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .description_page_url = "DescriptionPageUrl",
        .image_source_bands = "ImageSourceBands",
        .name = "Name",
        .supported_filters = "SupportedFilters",
        .tags = "Tags",
        .type = "Type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRasterDataCollectionInput, options: CallOptions) !GetRasterDataCollectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRasterDataCollectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker-geospatial", "SageMaker Geospatial", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/raster-data-collection/");
    try path_buf.appendSlice(allocator, input.arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRasterDataCollectionOutput {
    const result: GetRasterDataCollectionOutput = try aws.json.parseJsonObject(
        GetRasterDataCollectionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
