const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImageIdentifier = @import("image_identifier.zig").ImageIdentifier;
const ImageScanStatus = @import("image_scan_status.zig").ImageScanStatus;

pub const StartImageScanInput = struct {
    image_id: ImageIdentifier,

    /// The Amazon Web Services account ID associated with the registry that
    /// contains the repository in
    /// which to start an image scan request. If you do not specify a registry, the
    /// default registry is assumed.
    registry_id: ?[]const u8 = null,

    /// The name of the repository that contains the images to scan.
    repository_name: []const u8,

    pub const json_field_names = .{
        .image_id = "imageId",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};

pub const StartImageScanOutput = struct {
    image_id: ?ImageIdentifier = null,

    /// The current state of the scan.
    image_scan_status: ?ImageScanStatus = null,

    /// The registry ID associated with the request.
    registry_id: ?[]const u8 = null,

    /// The repository name associated with the request.
    repository_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_id = "imageId",
        .image_scan_status = "imageScanStatus",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartImageScanInput, options: CallOptions) !StartImageScanOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartImageScanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.ecr", "ECR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerRegistry_V20150921.StartImageScan");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartImageScanOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartImageScanOutput, body, allocator);
}
