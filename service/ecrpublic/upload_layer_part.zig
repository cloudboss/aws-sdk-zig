const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UploadLayerPartInput = struct {
    /// The base64-encoded layer part payload.
    layer_part_blob: []const u8,

    /// The position of the first byte of the layer part witin the overall image
    /// layer.
    part_first_byte: i64,

    /// The position of the last byte of the layer part within the overall image
    /// layer.
    part_last_byte: i64,

    /// The Amazon Web Services account ID, or registry alias, that's associated
    /// with the registry that you're
    /// uploading layer parts to. If you do not specify a registry, the default
    /// public registry is assumed.
    registry_id: ?[]const u8 = null,

    /// The name of the repository that you're uploading layer parts to.
    repository_name: []const u8,

    /// The upload ID from a previous InitiateLayerUpload operation to
    /// associate with the layer part upload.
    upload_id: []const u8,

    pub const json_field_names = .{
        .layer_part_blob = "layerPartBlob",
        .part_first_byte = "partFirstByte",
        .part_last_byte = "partLastByte",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
        .upload_id = "uploadId",
    };
};

pub const UploadLayerPartOutput = struct {
    /// The integer value of the last byte that's received in the request.
    last_byte_received: ?i64 = null,

    /// The registry ID that's associated with the request.
    registry_id: ?[]const u8 = null,

    /// The repository name that's associated with the request.
    repository_name: ?[]const u8 = null,

    /// The upload ID that's associated with the request.
    upload_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_byte_received = "lastByteReceived",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
        .upload_id = "uploadId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UploadLayerPartInput, options: CallOptions) !UploadLayerPartOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UploadLayerPartInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SpencerFrontendService.UploadLayerPart");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UploadLayerPartOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UploadLayerPartOutput, body, allocator);
}
