const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Format = @import("format.zig").Format;
const ImageSelectorType = @import("image_selector_type.zig").ImageSelectorType;
const Image = @import("image.zig").Image;

pub const GetImagesInput = struct {
    /// The end timestamp for the range of images to be generated. If the time range
    /// between `StartTimestamp` and `EndTimestamp` is more than 300 seconds above
    /// `StartTimestamp`, you will receive an `IllegalArgumentException`.
    end_timestamp: i64,

    /// The format that will be used to encode the image.
    format: Format,

    /// The list of a key-value pair structure that contains extra parameters that
    /// can be applied when the image is generated. The `FormatConfig` key is the
    /// `JPEGQuality`, which indicates the JPEG quality key to be used to generate
    /// the image.
    /// The `FormatConfig` value accepts ints from 1 to 100. If the value is 1, the
    /// image will be generated with less quality and the best compression.
    /// If the value is 100, the image will be generated with the best quality and
    /// less compression. If no value is provided, the default value of the
    /// `JPEGQuality` key will be set to 80.
    format_config: ?[]const aws.map.StringMapEntry = null,

    /// The height of the output image that is used in conjunction with the
    /// `WidthPixels` parameter. When both `HeightPixels` and `WidthPixels`
    /// parameters are provided, the image will be stretched to fit the
    /// specified aspect ratio. If only the `HeightPixels` parameter is provided,
    /// its original aspect ratio will be used to calculate the `WidthPixels` ratio.
    /// If neither parameter is provided,
    /// the original image size will be returned.
    height_pixels: ?i32 = null,

    /// The origin of the Server or Producer timestamps to use to generate the
    /// images.
    image_selector_type: ImageSelectorType,

    /// The maximum number of images to be returned by the API.
    ///
    /// The default limit is 25 images per API response. Providing a `MaxResults`
    /// greater than this value will result in a page size of 25. Any additional
    /// results will be paginated.
    max_results: ?i64 = null,

    /// A token that specifies where to start paginating the next set of Images.
    /// This is the `GetImages:NextToken` from a previously truncated response.
    next_token: ?[]const u8 = null,

    /// The time interval in milliseconds (ms) at which the images need to be
    /// generated from the stream. The minimum value that can be provided is 200 ms
    /// (5 images per second). If the timestamp range is less than the sampling
    /// interval, the image from the `startTimestamp` will be returned if available.
    sampling_interval: ?i32 = null,

    /// The starting point from which the images should be generated. This
    /// `StartTimestamp` must be within an inclusive range of timestamps for an
    /// image to be returned.
    start_timestamp: i64,

    /// The Amazon Resource Name (ARN) of the stream from which to retrieve the
    /// images. You must specify either the `StreamName` or the `StreamARN`.
    stream_arn: ?[]const u8 = null,

    /// The name of the stream from which to retrieve the images. You must specify
    /// either the `StreamName` or the `StreamARN`.
    stream_name: ?[]const u8 = null,

    /// The width of the output image that is used in conjunction with the
    /// `HeightPixels` parameter. When both `WidthPixels` and `HeightPixels`
    /// parameters are provided,
    /// the image will be stretched to fit the specified aspect ratio. If only the
    /// `WidthPixels` parameter is provided or if only the `HeightPixels` is
    /// provided, a `ValidationException` will be thrown.
    /// If neither parameter is provided, the original image size from the stream
    /// will be returned.
    width_pixels: ?i32 = null,

    pub const json_field_names = .{
        .end_timestamp = "EndTimestamp",
        .format = "Format",
        .format_config = "FormatConfig",
        .height_pixels = "HeightPixels",
        .image_selector_type = "ImageSelectorType",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sampling_interval = "SamplingInterval",
        .start_timestamp = "StartTimestamp",
        .stream_arn = "StreamARN",
        .stream_name = "StreamName",
        .width_pixels = "WidthPixels",
    };
};

pub const GetImagesOutput = struct {
    /// The list of images generated from the video stream. If there is no media
    /// available for the given timestamp, the `NO_MEDIA` error will be listed in
    /// the output.
    /// If an error occurs while the image is being generated, the `MEDIA_ERROR`
    /// will be listed in the output as the cause of the missing image.
    images: ?[]const Image = null,

    /// The encrypted token that was used in the request to get more images.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .images = "Images",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetImagesInput, options: CallOptions) !GetImagesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "kinesisvideo");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetImagesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideo", "Kinesis Video Archived Media", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/getImages";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EndTimestamp\":");
    try aws.json.writeValue(@TypeOf(input.end_timestamp), input.end_timestamp, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Format\":");
    try aws.json.writeValue(@TypeOf(input.format), input.format, allocator, &body_buf);
    has_prev = true;
    if (input.format_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FormatConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.height_pixels) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"HeightPixels\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ImageSelectorType\":");
    try aws.json.writeValue(@TypeOf(input.image_selector_type), input.image_selector_type, allocator, &body_buf);
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
    if (input.sampling_interval) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SamplingInterval\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StartTimestamp\":");
    try aws.json.writeValue(@TypeOf(input.start_timestamp), input.start_timestamp, allocator, &body_buf);
    has_prev = true;
    if (input.stream_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StreamARN\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stream_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StreamName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.width_pixels) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WidthPixels\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetImagesOutput {
    var result: GetImagesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetImagesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ClientLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .client_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArgumentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCodecPrivateDataException")) {
        return .{ .arena = arena, .kind = .{ .invalid_codec_private_data_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidMediaFrameException")) {
        return .{ .arena = arena, .kind = .{ .invalid_media_frame_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingCodecPrivateDataException")) {
        return .{ .arena = arena, .kind = .{ .missing_codec_private_data_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoDataRetentionException")) {
        return .{ .arena = arena, .kind = .{ .no_data_retention_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotAuthorizedException")) {
        return .{ .arena = arena, .kind = .{ .not_authorized_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnsupportedStreamMediaTypeException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_stream_media_type_exception = .{
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
