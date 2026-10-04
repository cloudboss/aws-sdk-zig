const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ThumbnailDetails = @import("thumbnail_details.zig").ThumbnailDetails;

pub const DescribeFlowSourceThumbnailInput = struct {
    /// The Amazon Resource Name (ARN) of the flow.
    flow_arn: []const u8,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
    };
};

pub const DescribeFlowSourceThumbnailOutput = struct {
    /// The details of the thumbnail, including thumbnail base64 string, timecode
    /// and the time when thumbnail was generated.
    thumbnail_details: ?ThumbnailDetails = null,

    pub const json_field_names = .{
        .thumbnail_details = "ThumbnailDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFlowSourceThumbnailInput, options: CallOptions) !DescribeFlowSourceThumbnailOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFlowSourceThumbnailInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/flows/");
    try path_buf.appendSlice(allocator, input.flow_arn);
    try path_buf.appendSlice(allocator, "/source-thumbnail");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFlowSourceThumbnailOutput {
    var result: DescribeFlowSourceThumbnailOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeFlowSourceThumbnailOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
