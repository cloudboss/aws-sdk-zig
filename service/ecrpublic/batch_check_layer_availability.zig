const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LayerFailure = @import("layer_failure.zig").LayerFailure;
const Layer = @import("layer.zig").Layer;

pub const BatchCheckLayerAvailabilityInput = struct {
    /// The digests of the image layers to check.
    layer_digests: []const []const u8,

    /// The Amazon Web Services account ID, or registry alias, associated with the
    /// public registry that
    /// contains the image layers to check. If you do not specify a registry, the
    /// default public registry is assumed.
    registry_id: ?[]const u8 = null,

    /// The name of the repository that's associated with the image layers to check.
    repository_name: []const u8,

    pub const json_field_names = .{
        .layer_digests = "layerDigests",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};

pub const BatchCheckLayerAvailabilityOutput = struct {
    /// Any failures associated with the call.
    failures: ?[]const LayerFailure = null,

    /// A list of image layer objects that correspond to the image layer references
    /// in the
    /// request.
    layers: ?[]const Layer = null,

    pub const json_field_names = .{
        .failures = "failures",
        .layers = "layers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchCheckLayerAvailabilityInput, options: CallOptions) !BatchCheckLayerAvailabilityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchCheckLayerAvailabilityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SpencerFrontendService.BatchCheckLayerAvailability");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchCheckLayerAvailabilityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchCheckLayerAvailabilityOutput, body, allocator);
}
