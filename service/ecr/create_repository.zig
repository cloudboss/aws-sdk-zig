const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const ImageScanningConfiguration = @import("image_scanning_configuration.zig").ImageScanningConfiguration;
const ImageTagMutability = @import("image_tag_mutability.zig").ImageTagMutability;
const ImageTagMutabilityExclusionFilter = @import("image_tag_mutability_exclusion_filter.zig").ImageTagMutabilityExclusionFilter;
const Tag = @import("tag.zig").Tag;
const Repository = @import("repository.zig").Repository;

pub const CreateRepositoryInput = struct {
    /// The encryption configuration for the repository. This determines how the
    /// contents of
    /// your repository are encrypted at rest.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The `imageScanningConfiguration` parameter is being deprecated, in
    /// favor of specifying the image scanning configuration at the registry level.
    /// For more
    /// information, see `PutRegistryScanningConfiguration`.
    ///
    /// The image scanning configuration for the repository. This determines whether
    /// images
    /// are scanned for known vulnerabilities after being pushed to the repository.
    image_scanning_configuration: ?ImageScanningConfiguration = null,

    /// The tag mutability setting for the repository. If this parameter is omitted,
    /// the
    /// default setting of `MUTABLE` will be used which will allow image tags to be
    /// overwritten. If `IMMUTABLE` is specified, all image tags within the
    /// repository will be immutable which will prevent them from being overwritten.
    image_tag_mutability: ?ImageTagMutability = null,

    /// A list of filters that specify which image tags should be excluded from the
    /// repository's image tag mutability setting.
    image_tag_mutability_exclusion_filters: ?[]const ImageTagMutabilityExclusionFilter = null,

    /// The Amazon Web Services account ID associated with the registry to create
    /// the repository.
    /// If you do not specify a registry, the default registry is assumed.
    registry_id: ?[]const u8 = null,

    /// The name to use for the repository. The repository name may be specified on
    /// its own
    /// (such as `nginx-web-app`) or it can be prepended with a namespace to group
    /// the repository into a category (such as `project-a/nginx-web-app`).
    ///
    /// The repository name must start with a letter and can only contain lowercase
    /// letters,
    /// numbers, hyphens, underscores, and forward slashes.
    repository_name: []const u8,

    /// The metadata that you apply to the repository to help you categorize and
    /// organize
    /// them. Each tag consists of a key and an optional value, both of which you
    /// define.
    /// Tag keys can have a maximum character length of 128 characters, and tag
    /// values can have
    /// a maximum length of 256 characters.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .encryption_configuration = "encryptionConfiguration",
        .image_scanning_configuration = "imageScanningConfiguration",
        .image_tag_mutability = "imageTagMutability",
        .image_tag_mutability_exclusion_filters = "imageTagMutabilityExclusionFilters",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
        .tags = "tags",
    };
};

pub const CreateRepositoryOutput = struct {
    /// The repository that was created.
    repository: ?Repository = null,

    pub const json_field_names = .{
        .repository = "repository",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRepositoryInput, options: CallOptions) !CreateRepositoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRepositoryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerRegistry_V20150921.CreateRepository");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRepositoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateRepositoryOutput, body, allocator);
}
