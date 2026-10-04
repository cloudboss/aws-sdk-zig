const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CopyImageInput = struct {
    /// The description that the image will have when it is copied to the
    /// destination.
    destination_image_description: ?[]const u8 = null,

    /// The name that the image will have when it is copied to the destination.
    destination_image_name: []const u8,

    /// The destination region to which the image will be copied. This parameter is
    /// required, even if you are copying an image within the same region.
    destination_region: []const u8,

    /// The name of the image to copy.
    source_image_name: []const u8,

    pub const json_field_names = .{
        .destination_image_description = "DestinationImageDescription",
        .destination_image_name = "DestinationImageName",
        .destination_region = "DestinationRegion",
        .source_image_name = "SourceImageName",
    };
};

pub const CopyImageOutput = struct {
    /// The name of the destination image.
    destination_image_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_image_name = "DestinationImageName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopyImageInput, options: CallOptions) !CopyImageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appstream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CopyImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream2", "AppStream", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.CopyImage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopyImageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CopyImageOutput, body, allocator);
}
