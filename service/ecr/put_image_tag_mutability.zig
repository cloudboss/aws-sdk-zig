const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImageTagMutability = @import("image_tag_mutability.zig").ImageTagMutability;
const ImageTagMutabilityExclusionFilter = @import("image_tag_mutability_exclusion_filter.zig").ImageTagMutabilityExclusionFilter;

pub const PutImageTagMutabilityInput = struct {
    /// The tag mutability setting for the repository. If `MUTABLE` is specified,
    /// image tags can be overwritten. If `IMMUTABLE` is specified, all image tags
    /// within the repository will be immutable which will prevent them from being
    /// overwritten.
    image_tag_mutability: ImageTagMutability,

    /// A list of filters that specify which image tags should be excluded from the
    /// image tag
    /// mutability setting being applied.
    image_tag_mutability_exclusion_filters: ?[]const ImageTagMutabilityExclusionFilter = null,

    /// The Amazon Web Services account ID associated with the registry that
    /// contains the repository in
    /// which to update the image tag mutability settings. If you do not specify a
    /// registry, the default registry is assumed.
    registry_id: ?[]const u8 = null,

    /// The name of the repository in which to update the image tag mutability
    /// settings.
    repository_name: []const u8,

    pub const json_field_names = .{
        .image_tag_mutability = "imageTagMutability",
        .image_tag_mutability_exclusion_filters = "imageTagMutabilityExclusionFilters",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};

pub const PutImageTagMutabilityOutput = struct {
    /// The image tag mutability setting for the repository.
    image_tag_mutability: ?ImageTagMutability = null,

    /// The list of filters that specify which image tags are excluded from the
    /// repository's
    /// image tag mutability setting.
    image_tag_mutability_exclusion_filters: ?[]const ImageTagMutabilityExclusionFilter = null,

    /// The registry ID associated with the request.
    registry_id: ?[]const u8 = null,

    /// The repository name associated with the request.
    repository_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_tag_mutability = "imageTagMutability",
        .image_tag_mutability_exclusion_filters = "imageTagMutabilityExclusionFilters",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutImageTagMutabilityInput, options: CallOptions) !PutImageTagMutabilityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutImageTagMutabilityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerRegistry_V20150921.PutImageTagMutability");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutImageTagMutabilityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutImageTagMutabilityOutput, body, allocator);
}
