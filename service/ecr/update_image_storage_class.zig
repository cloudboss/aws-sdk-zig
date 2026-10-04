const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImageIdentifier = @import("image_identifier.zig").ImageIdentifier;
const TargetStorageClass = @import("target_storage_class.zig").TargetStorageClass;
const ImageStatus = @import("image_status.zig").ImageStatus;

pub const UpdateImageStorageClassInput = struct {
    image_id: ImageIdentifier,

    /// The Amazon Web Services account ID associated with the registry that
    /// contains the image to transition. If you do not specify a registry, the
    /// default registry is assumed.
    registry_id: ?[]const u8 = null,

    /// The name of the repository that contains the image to transition.
    repository_name: []const u8,

    /// The target storage class for the image.
    target_storage_class: TargetStorageClass,

    pub const json_field_names = .{
        .image_id = "imageId",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
        .target_storage_class = "targetStorageClass",
    };
};

pub const UpdateImageStorageClassOutput = struct {
    image_id: ?ImageIdentifier = null,

    /// The current status of the image after the call to UpdateImageStorageClass is
    /// complete. Valid values are `ACTIVE`, `ARCHIVED`, and `ACTIVATING`.
    image_status: ?ImageStatus = null,

    /// The registry ID associated with the request.
    registry_id: ?[]const u8 = null,

    /// The repository name associated with the request.
    repository_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_id = "imageId",
        .image_status = "imageStatus",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateImageStorageClassInput, options: CallOptions) !UpdateImageStorageClassOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateImageStorageClassInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerRegistry_V20150921.UpdateImageStorageClass");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateImageStorageClassOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateImageStorageClassOutput, body, allocator);
}
