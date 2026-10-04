const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChannelType = @import("channel_type.zig").ChannelType;
const SingleMasterConfiguration = @import("single_master_configuration.zig").SingleMasterConfiguration;
const Tag = @import("tag.zig").Tag;

pub const CreateSignalingChannelInput = struct {
    /// A name for the signaling channel that you are creating. It must be unique
    /// for each Amazon Web Services account and Amazon Web Services Region.
    channel_name: []const u8,

    /// A type of the signaling channel that you are creating. Currently,
    /// `SINGLE_MASTER` is the only supported channel type.
    channel_type: ?ChannelType = null,

    /// A structure containing the configuration for the `SINGLE_MASTER` channel
    /// type. The default configuration for the channel message's time to live is 60
    /// seconds (1
    /// minute).
    single_master_configuration: ?SingleMasterConfiguration = null,

    /// A set of tags (key-value pairs) that you want to associate with this
    /// channel.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .channel_name = "ChannelName",
        .channel_type = "ChannelType",
        .single_master_configuration = "SingleMasterConfiguration",
        .tags = "Tags",
    };
};

pub const CreateSignalingChannelOutput = struct {
    /// The Amazon Resource Name (ARN) of the created channel.
    channel_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSignalingChannelInput, options: CallOptions) !CreateSignalingChannelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSignalingChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideo", "Kinesis Video", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/createSignalingChannel";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ChannelName\":");
    try aws.json.writeValue(@TypeOf(input.channel_name), input.channel_name, allocator, &body_buf);
    has_prev = true;
    if (input.channel_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ChannelType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.single_master_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SingleMasterConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSignalingChannelOutput {
    var result: CreateSignalingChannelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSignalingChannelOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
