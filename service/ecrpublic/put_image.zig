const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Image = @import("image.zig").Image;

pub const PutImageInput = struct {
    /// The image digest of the image manifest that corresponds to the image.
    image_digest: ?[]const u8 = null,

    /// The image manifest that corresponds to the image to be uploaded.
    image_manifest: []const u8,

    /// The media type of the image manifest. If you push an image manifest that
    /// doesn't contain
    /// the `mediaType` field, you must specify the `imageManifestMediaType`
    /// in the request.
    image_manifest_media_type: ?[]const u8 = null,

    /// The tag to associate with the image. This parameter is required for images
    /// that use the
    /// Docker Image Manifest V2 Schema 2 or Open Container Initiative (OCI)
    /// formats.
    image_tag: ?[]const u8 = null,

    /// The Amazon Web Services account ID, or registry alias, that's associated
    /// with the public registry that
    /// contains the repository where the image is put. If you do not specify a
    /// registry, the default public registry is assumed.
    registry_id: ?[]const u8 = null,

    /// The name of the repository where the image is put.
    repository_name: []const u8,

    pub const json_field_names = .{
        .image_digest = "imageDigest",
        .image_manifest = "imageManifest",
        .image_manifest_media_type = "imageManifestMediaType",
        .image_tag = "imageTag",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};

pub const PutImageOutput = struct {
    /// Details of the image uploaded.
    image: ?Image = null,

    pub const json_field_names = .{
        .image = "image",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutImageInput, options: CallOptions) !PutImageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecr-public", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.ecr-public", "ECR PUBLIC", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SpencerFrontendService.PutImage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutImageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutImageOutput, body, allocator);
}
