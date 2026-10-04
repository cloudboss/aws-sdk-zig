const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Queue = @import("queue.zig").Queue;

pub const GetQueueInput = struct {
    /// The name of the queue that you want information about.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const GetQueueOutput = struct {
    /// You can use queues to manage the resources that are available to your AWS
    /// account for running multiple transcoding jobs at the same time. If you don't
    /// specify a queue, the service sends all jobs through the default queue. For
    /// more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/working-with-queues.html.
    queue: ?Queue = null,

    pub const json_field_names = .{
        .queue = "Queue",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQueueInput, options: CallOptions) !GetQueueOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediaconvert", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetQueueInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconvert", "MediaConvert", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2017-08-29/queues/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQueueOutput {
    var result: GetQueueOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetQueueOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
