const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CancelHarvestJobInput = struct {
    /// The name of the channel group containing the channel from which the harvest
    /// job is running.
    channel_group_name: []const u8,

    /// The name of the channel from which the harvest job is running.
    channel_name: []const u8,

    /// The current Entity Tag (ETag) associated with the harvest job. Used for
    /// concurrency control.
    e_tag: ?[]const u8 = null,

    /// The name of the harvest job to cancel. This name must be unique within the
    /// channel and cannot be changed after the harvest job is submitted.
    harvest_job_name: []const u8,

    /// The name of the origin endpoint that the harvest job is harvesting from.
    /// This cannot be changed after the harvest job is submitted.
    origin_endpoint_name: []const u8,

    pub const json_field_names = .{
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .e_tag = "ETag",
        .harvest_job_name = "HarvestJobName",
        .origin_endpoint_name = "OriginEndpointName",
    };
};

pub const CancelHarvestJobOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelHarvestJobInput, options: CallOptions) !CancelHarvestJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediapackagev2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelHarvestJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediapackagev2", "MediaPackageV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channelGroup/");
    try path_buf.appendSlice(allocator, input.channel_group_name);
    try path_buf.appendSlice(allocator, "/channel/");
    try path_buf.appendSlice(allocator, input.channel_name);
    try path_buf.appendSlice(allocator, "/originEndpoint/");
    try path_buf.appendSlice(allocator, input.origin_endpoint_name);
    try path_buf.appendSlice(allocator, "/harvestJob/");
    try path_buf.appendSlice(allocator, input.harvest_job_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.e_tag) |v| {
        try request.headers.put(allocator, "x-amzn-update-if-match", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelHarvestJobOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: CancelHarvestJobOutput = .{};

    return result;
}
