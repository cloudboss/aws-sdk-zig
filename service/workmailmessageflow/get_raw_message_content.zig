const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetRawMessageContentInput = struct {
    /// The identifier of the email message to retrieve.
    message_id: []const u8,

    pub const json_field_names = .{
        .message_id = "messageId",
    };
};

pub const GetRawMessageContentOutput = struct {
    /// The raw content of the email message, in MIME format.
    message_content: aws.http.StreamingBody = undefined,

    pub fn deinit(self: *GetRawMessageContentOutput) void {
        self.message_content.deinit();
    }

    pub const json_field_names = .{
        .message_content = "messageContent",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRawMessageContentInput, options: CallOptions) !GetRawMessageContentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workmailmessageflow", client.config.http_client.clock_skew_offset);

    var stream_resp = try client.config.http_client.sendStreamingRequestWithOptions(&request, client.options);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, error_body, stream_resp.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetRawMessageContentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workmailmessageflow", "WorkMailMessageFlow", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/messages/");
    try path_buf.appendSlice(allocator, input.message_id);
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

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !GetRawMessageContentOutput {
    _ = allocator;
    var result: GetRawMessageContentOutput = .{};
    result.message_content = stream_resp.body;
    stream_resp.deinitHeaders();

    return result;
}
