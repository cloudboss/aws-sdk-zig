const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SingleMasterConfiguration = @import("single_master_configuration.zig").SingleMasterConfiguration;

pub const UpdateSignalingChannelInput = struct {
    /// The Amazon Resource Name (ARN) of the signaling channel that you want to
    /// update.
    channel_arn: []const u8,

    /// The current version of the signaling channel that you want to update.
    current_version: []const u8,

    /// The structure containing the configuration for the `SINGLE_MASTER` type of
    /// the signaling channel that you want to update. This parameter and the
    /// channel message's
    /// time-to-live are required for channels with the `SINGLE_MASTER` channel
    /// type.
    single_master_configuration: ?SingleMasterConfiguration = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelARN",
        .current_version = "CurrentVersion",
        .single_master_configuration = "SingleMasterConfiguration",
    };
};

pub const UpdateSignalingChannelOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSignalingChannelInput, options: CallOptions) !UpdateSignalingChannelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSignalingChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideo", "Kinesis Video", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/updateSignalingChannel";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ChannelARN\":");
    try aws.json.writeValue(@TypeOf(input.channel_arn), input.channel_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CurrentVersion\":");
    try aws.json.writeValue(@TypeOf(input.current_version), input.current_version, allocator, &body_buf);
    has_prev = true;
    if (input.single_master_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SingleMasterConfiguration\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSignalingChannelOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateSignalingChannelOutput = .{};

    return result;
}
