const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AccessConfiguration = @import("access_configuration.zig").AccessConfiguration;
const DefaultSegmentDeliveryConfiguration = @import("default_segment_delivery_configuration.zig").DefaultSegmentDeliveryConfiguration;
const HttpConfiguration = @import("http_configuration.zig").HttpConfiguration;
const SegmentDeliveryConfiguration = @import("segment_delivery_configuration.zig").SegmentDeliveryConfiguration;

pub const UpdateSourceLocationInput = struct {
    /// Access configuration parameters. Configures the type of authentication used
    /// to access content from your source location.
    access_configuration: ?AccessConfiguration = null,

    /// The optional configuration for the host server that serves segments.
    default_segment_delivery_configuration: ?DefaultSegmentDeliveryConfiguration = null,

    /// The HTTP configuration for the source location.
    http_configuration: HttpConfiguration,

    /// A list of the segment delivery configurations associated with this resource.
    segment_delivery_configurations: ?[]const SegmentDeliveryConfiguration = null,

    /// The name of the source location.
    source_location_name: []const u8,

    pub const json_field_names = .{
        .access_configuration = "AccessConfiguration",
        .default_segment_delivery_configuration = "DefaultSegmentDeliveryConfiguration",
        .http_configuration = "HttpConfiguration",
        .segment_delivery_configurations = "SegmentDeliveryConfigurations",
        .source_location_name = "SourceLocationName",
    };
};

pub const UpdateSourceLocationOutput = struct {
    /// Access configuration parameters. Configures the type of authentication used
    /// to access content from your source location.
    access_configuration: ?AccessConfiguration = null,

    /// The Amazon Resource Name (ARN) associated with the source location.
    arn: ?[]const u8 = null,

    /// The timestamp that indicates when the source location was created.
    creation_time: ?i64 = null,

    /// The optional configuration for the host server that serves segments.
    default_segment_delivery_configuration: ?DefaultSegmentDeliveryConfiguration = null,

    /// The HTTP configuration for the source location.
    http_configuration: ?HttpConfiguration = null,

    /// The timestamp that indicates when the source location was last modified.
    last_modified_time: ?i64 = null,

    /// The segment delivery configurations for the source location. For information
    /// about MediaTailor configurations, see [Working with configurations in AWS
    /// Elemental
    /// MediaTailor](https://docs.aws.amazon.com/mediatailor/latest/ug/configurations.html).
    segment_delivery_configurations: ?[]const SegmentDeliveryConfiguration = null,

    /// The name of the source location.
    source_location_name: ?[]const u8 = null,

    /// The tags to assign to the source location. Tags are key-value pairs that you
    /// can associate with Amazon resources to help with organization, access
    /// control, and cost tracking. For more information, see [Tagging AWS Elemental
    /// MediaTailor
    /// Resources](https://docs.aws.amazon.com/mediatailor/latest/ug/tagging.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .access_configuration = "AccessConfiguration",
        .arn = "Arn",
        .creation_time = "CreationTime",
        .default_segment_delivery_configuration = "DefaultSegmentDeliveryConfiguration",
        .http_configuration = "HttpConfiguration",
        .last_modified_time = "LastModifiedTime",
        .segment_delivery_configurations = "SegmentDeliveryConfigurations",
        .source_location_name = "SourceLocationName",
        .tags = "Tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSourceLocationInput, options: Options) !UpdateSourceLocationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mediatailor");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateSourceLocationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediatailor", "MediaTailor", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/sourceLocation/");
    try path_buf.appendSlice(alloc, input.source_location_name);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.access_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AccessConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.default_segment_delivery_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DefaultSegmentDeliveryConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"HttpConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.http_configuration), input.http_configuration, alloc, &body_buf);
    has_prev = true;
    if (input.segment_delivery_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SegmentDeliveryConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateSourceLocationOutput {
    var result: UpdateSourceLocationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateSourceLocationOutput, body, alloc);
    }
    _ = status;
    _ = headers;

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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
