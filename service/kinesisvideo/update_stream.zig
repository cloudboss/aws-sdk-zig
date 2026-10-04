const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateStreamInput = struct {
    /// The version of the stream whose metadata you want to update.
    current_version: []const u8,

    /// The name of the device that is writing to the stream.
    ///
    /// In the current implementation, Kinesis Video Streams does not use this name.
    device_name: ?[]const u8 = null,

    /// The stream's media type. Use `MediaType` to specify the type of content
    /// that the stream contains to the consumers of the stream. For more
    /// information about
    /// media types, see [Media
    /// Types](http://www.iana.org/assignments/media-types/media-types.xhtml). If
    /// you choose to specify the `MediaType`, see [Naming
    /// Requirements](https://tools.ietf.org/html/rfc6838#section-4.2).
    ///
    /// To play video on the console, you must specify the correct video type. For
    /// example,
    /// if the video in the stream is H.264, specify `video/h264` as the
    /// `MediaType`.
    media_type: ?[]const u8 = null,

    /// The ARN of the stream whose metadata you want to update.
    stream_arn: ?[]const u8 = null,

    /// The name of the stream whose metadata you want to update.
    ///
    /// The stream name is an identifier for the stream, and must be unique for each
    /// account and region.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .current_version = "CurrentVersion",
        .device_name = "DeviceName",
        .media_type = "MediaType",
        .stream_arn = "StreamARN",
        .stream_name = "StreamName",
    };
};

pub const UpdateStreamOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateStreamInput, options: CallOptions) !UpdateStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesisvideo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideo", "Kinesis Video", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/updateStream";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CurrentVersion\":");
    try aws.json.writeValue(@TypeOf(input.current_version), input.current_version, allocator, &body_buf);
    has_prev = true;
    if (input.device_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DeviceName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.media_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MediaType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateStreamOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateStreamOutput = .{};

    return result;
}
