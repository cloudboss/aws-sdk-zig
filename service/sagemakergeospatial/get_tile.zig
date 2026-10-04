const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OutputType = @import("output_type.zig").OutputType;
const TargetOptions = @import("target_options.zig").TargetOptions;

pub const GetTileInput = struct {
    /// The Amazon Resource Name (ARN) of the tile operation.
    arn: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role that you specify.
    execution_role_arn: ?[]const u8 = null,

    /// The particular assets or bands to tile.
    image_assets: []const []const u8,

    /// Determines whether or not to return a valid data mask.
    image_mask: ?bool = null,

    /// The output data type of the tile operation.
    output_data_type: ?OutputType = null,

    /// The data format of the output tile. The formats include .npy, .png and .jpg.
    output_format: ?[]const u8 = null,

    /// Property filters for the imagery to tile.
    property_filters: ?[]const u8 = null,

    /// Determines what part of the Earth Observation job to tile. 'INPUT' or
    /// 'OUTPUT' are the valid options.
    target: TargetOptions,

    /// Time range filter applied to imagery to find the images to tile.
    time_range_filter: ?[]const u8 = null,

    /// The x coordinate of the tile input.
    x: i32,

    /// The y coordinate of the tile input.
    y: i32,

    /// The z coordinate of the tile input.
    z: i32,

    pub const json_field_names = .{
        .arn = "Arn",
        .execution_role_arn = "ExecutionRoleArn",
        .image_assets = "ImageAssets",
        .image_mask = "ImageMask",
        .output_data_type = "OutputDataType",
        .output_format = "OutputFormat",
        .property_filters = "PropertyFilters",
        .target = "Target",
        .time_range_filter = "TimeRangeFilter",
        .x = "x",
        .y = "y",
        .z = "z",
    };
};

pub const GetTileOutput = struct {
    /// The output binary file.
    binary_file: ?aws.http.StreamingBody = null,

    pub fn deinit(self: *GetTileOutput) void {
        if (self.binary_file) |*b| b.deinit();
    }

    pub const json_field_names = .{
        .binary_file = "BinaryFile",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTileInput, options: CallOptions) !GetTileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker-geospatial", client.config.http_client.clock_skew_offset);

    var stream_resp = try client.config.http_client.sendStreamingRequestWithOptions(&request, client.options);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, error_body, stream_resp.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetTileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker-geospatial", "SageMaker Geospatial", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/tile/");
    try path_buf.appendSlice(allocator, input.z);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.x);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.y);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "Arn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.arn);
    query_has_prev = true;
    if (input.execution_role_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ExecutionRoleArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    for (input.image_assets) |item| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ImageAssets=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, item);
        query_has_prev = true;
    }
    if (input.image_mask) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ImageMask=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.output_data_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "OutputDataType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.output_format) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "OutputFormat=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.property_filters) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "PropertyFilters=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "Target=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.target.wireName());
    query_has_prev = true;
    if (input.time_range_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "TimeRangeFilter=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !GetTileOutput {
    _ = allocator;
    var result: GetTileOutput = .{};
    result.binary_file = stream_resp.body;
    stream_resp.deinitHeaders();

    return result;
}
