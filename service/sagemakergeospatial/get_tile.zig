const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTileInput, options: Options) !GetTileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemakergeospatial");

    var stream_resp = try client.http_client.sendStreamingRequest(&request);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(error_body, stream_resp.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(stream_resp.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeStreamingResponse(&stream_resp, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetTileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemakergeospatial", "SageMaker Geospatial", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/tile/");
    try path_buf.appendSlice(alloc, input.z);
    try path_buf.appendSlice(alloc, "/");
    try path_buf.appendSlice(alloc, input.x);
    try path_buf.appendSlice(alloc, "/");
    try path_buf.appendSlice(alloc, input.y);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "Arn=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.arn);
    query_has_prev = true;
    if (input.execution_role_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "ExecutionRoleArn=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "ImageAssets=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.image_assets);
    query_has_prev = true;
    if (input.image_mask) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "ImageMask=");
        try query_buf.appendSlice(alloc, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.output_data_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "OutputDataType=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    if (input.output_format) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "OutputFormat=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.property_filters) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "PropertyFilters=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "Target=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, @tagName(input.target));
    query_has_prev = true;
    if (input.time_range_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "TimeRangeFilter=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeStreamingResponse(stream_resp: *aws.http.StreamingResponse, alloc: std.mem.Allocator) !GetTileOutput {
    _ = alloc;
    var result: GetTileOutput = .{};
    result.binary_file = stream_resp.body;
    stream_resp.deinitHeaders();

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
