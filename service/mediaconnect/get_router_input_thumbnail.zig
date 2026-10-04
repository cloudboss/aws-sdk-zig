const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RouterInputThumbnailDetails = @import("router_input_thumbnail_details.zig").RouterInputThumbnailDetails;

pub const GetRouterInputThumbnailInput = struct {
    /// The Amazon Resource Name (ARN) of the router input that you want to see a
    /// thumbnail of.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub const GetRouterInputThumbnailOutput = struct {
    /// The ARN of the router input.
    arn: []const u8,

    /// The name of the router input.
    name: []const u8,

    /// The details of the thumbnail associated with the router input, including the
    /// thumbnail image, timecode, timestamp, and any associated error messages.
    thumbnail_details: ?RouterInputThumbnailDetails = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
        .thumbnail_details = "ThumbnailDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRouterInputThumbnailInput, options: CallOptions) !GetRouterInputThumbnailOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediaconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRouterInputThumbnailInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/routerInput/");
    try path_buf.appendSlice(allocator, input.arn);
    try path_buf.appendSlice(allocator, "/thumbnail");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRouterInputThumbnailOutput {
    var result: GetRouterInputThumbnailOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRouterInputThumbnailOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
