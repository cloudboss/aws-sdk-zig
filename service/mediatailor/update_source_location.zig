const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSourceLocationInput, options: CallOptions) !UpdateSourceLocationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediatailor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSourceLocationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.mediatailor", "MediaTailor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sourceLocation/");
    try path_buf.appendSlice(allocator, input.source_location_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.access_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccessConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.default_segment_delivery_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DefaultSegmentDeliveryConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"HttpConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.http_configuration), input.http_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.segment_delivery_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SegmentDeliveryConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSourceLocationOutput {
    var result: UpdateSourceLocationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateSourceLocationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
