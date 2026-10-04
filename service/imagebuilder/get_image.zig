const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Image = @import("image.zig").Image;
const LatestVersionReferences = @import("latest_version_references.zig").LatestVersionReferences;

pub const GetImageInput = struct {
    /// The Amazon Resource Name (ARN) of the image that you want to get.
    image_build_version_arn: []const u8,

    pub const json_field_names = .{
        .image_build_version_arn = "imageBuildVersionArn",
    };
};

pub const GetImageOutput = struct {
    /// The image object.
    image: ?Image = null,

    /// The resource ARNs with different wildcard variations of semantic versioning.
    latest_version_references: ?LatestVersionReferences = null,

    /// The request ID that uniquely identifies this request.
    request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .image = "image",
        .latest_version_references = "latestVersionReferences",
        .request_id = "requestId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetImageInput, options: CallOptions) !GetImageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "imagebuilder", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetImage";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "imageBuildVersionArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.image_build_version_arn);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetImageOutput {
    var result: GetImageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetImageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
