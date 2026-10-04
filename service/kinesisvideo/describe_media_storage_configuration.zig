const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MediaStorageConfiguration = @import("media_storage_configuration.zig").MediaStorageConfiguration;

pub const DescribeMediaStorageConfigurationInput = struct {
    /// The Amazon Resource Name (ARN) of the channel.
    channel_arn: ?[]const u8 = null,

    /// The name of the channel.
    channel_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelARN",
        .channel_name = "ChannelName",
    };
};

pub const DescribeMediaStorageConfigurationOutput = struct {
    /// A structure that encapsulates, or contains, the media storage configuration
    /// properties.
    media_storage_configuration: ?MediaStorageConfiguration = null,

    pub const json_field_names = .{
        .media_storage_configuration = "MediaStorageConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMediaStorageConfigurationInput, options: CallOptions) !DescribeMediaStorageConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMediaStorageConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideo", "Kinesis Video", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/describeMediaStorageConfiguration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.channel_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ChannelARN\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.channel_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ChannelName\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMediaStorageConfigurationOutput {
    var result: DescribeMediaStorageConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeMediaStorageConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
