const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartViewerSessionRevocationInput = struct {
    /// The ARN of the channel associated with the viewer session to revoke.
    channel_arn: []const u8,

    /// The ID of the viewer associated with the viewer session to revoke. Do not
    /// use this field for personally identifying, confidential, or sensitive
    /// information.
    viewer_id: []const u8,

    /// An optional filter on which versions of the viewer session to revoke. All
    /// versions less than or equal to the specified version will be revoked.
    /// Default: 0.
    viewer_session_versions_less_than_or_equal_to: ?i32 = null,

    pub const json_field_names = .{
        .channel_arn = "channelArn",
        .viewer_id = "viewerId",
        .viewer_session_versions_less_than_or_equal_to = "viewerSessionVersionsLessThanOrEqualTo",
    };
};

pub const StartViewerSessionRevocationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartViewerSessionRevocationInput, options: CallOptions) !StartViewerSessionRevocationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ivs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartViewerSessionRevocationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivs", "ivs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/StartViewerSessionRevocation";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"channelArn\":");
    try aws.json.writeValue(@TypeOf(input.channel_arn), input.channel_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"viewerId\":");
    try aws.json.writeValue(@TypeOf(input.viewer_id), input.viewer_id, allocator, &body_buf);
    has_prev = true;
    if (input.viewer_session_versions_less_than_or_equal_to) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"viewerSessionVersionsLessThanOrEqualTo\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartViewerSessionRevocationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: StartViewerSessionRevocationOutput = .{};

    return result;
}
