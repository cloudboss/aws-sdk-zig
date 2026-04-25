const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Repository = @import("repository.zig").Repository;

pub const DescribeRepositoriesInput = struct {
    /// The maximum number of repository results returned by `DescribeRepositories`
    /// in paginated output. When this parameter is used, `DescribeRepositories`
    /// only
    /// returns `maxResults` results in a single page along with a
    /// `nextToken` response element. The remaining results of the initial
    /// request can be seen by sending another `DescribeRepositories` request with
    /// the returned `nextToken` value. This value can be between 1
    /// and 1000. If this parameter is not used, then
    /// `DescribeRepositories` returns up to 100 results and a
    /// `nextToken` value, if applicable. This option cannot be used when you
    /// specify repositories with `repositoryNames`.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated
    /// `DescribeRepositories` request where `maxResults` was used and
    /// the results exceeded the value of that parameter. Pagination continues from
    /// the end of
    /// the previous results that returned the `nextToken` value. This value is
    /// `null` when there are no more results to return. This option cannot be
    /// used when you specify repositories with `repositoryNames`.
    ///
    /// This token should be treated as an opaque identifier that is only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    /// The Amazon Web Services account ID associated with the registry that
    /// contains the repositories to be
    /// described. If you do not specify a registry, the default registry is
    /// assumed.
    registry_id: ?[]const u8 = null,

    /// A list of repositories to describe. If this parameter is omitted, then all
    /// repositories in a registry are described.
    repository_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .registry_id = "registryId",
        .repository_names = "repositoryNames",
    };
};

pub const DescribeRepositoriesOutput = struct {
    /// The `nextToken` value to include in a future
    /// `DescribeRepositories` request. When the results of a
    /// `DescribeRepositories` request exceed `maxResults`, this value
    /// can be used to retrieve the next page of results. This value is `null` when
    /// there are no more results to return.
    next_token: ?[]const u8 = null,

    /// A list of repository objects corresponding to valid repositories.
    repositories: ?[]const Repository = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .repositories = "repositories",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRepositoriesInput, options: CallOptions) !DescribeRepositoriesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ecr");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRepositoriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.ecr", "ECR", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerRegistry_V20150921.DescribeRepositories");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRepositoriesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeRepositoriesOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BlockedByOrganizationPolicyException")) {
        return .{ .arena = arena, .kind = .{ .blocked_by_organization_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EmptyUploadException")) {
        return .{ .arena = arena, .kind = .{ .empty_upload_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExclusionAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .exclusion_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExclusionNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .exclusion_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ImageAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .image_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ImageArchivedException")) {
        return .{ .arena = arena, .kind = .{ .image_archived_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ImageDigestDoesNotMatchException")) {
        return .{ .arena = arena, .kind = .{ .image_digest_does_not_match_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ImageNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .image_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ImageStorageClassUpdateNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .image_storage_class_update_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ImageTagAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .image_tag_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLayerException")) {
        return .{ .arena = arena, .kind = .{ .invalid_layer_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLayerPartException")) {
        return .{ .arena = arena, .kind = .{ .invalid_layer_part_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTagParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_tag_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KmsException")) {
        return .{ .arena = arena, .kind = .{ .kms_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LayerAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .layer_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LayerInaccessibleException")) {
        return .{ .arena = arena, .kind = .{ .layer_inaccessible_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LayerPartTooSmallException")) {
        return .{ .arena = arena, .kind = .{ .layer_part_too_small_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LayersNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .layers_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LifecyclePolicyNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .lifecycle_policy_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LifecyclePolicyPreviewInProgressException")) {
        return .{ .arena = arena, .kind = .{ .lifecycle_policy_preview_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LifecyclePolicyPreviewNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .lifecycle_policy_preview_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PullThroughCacheRuleAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .pull_through_cache_rule_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PullThroughCacheRuleNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .pull_through_cache_rule_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReferencedImagesNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .referenced_images_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RegistryPolicyNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .registry_policy_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RepositoryAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .repository_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RepositoryNotEmptyException")) {
        return .{ .arena = arena, .kind = .{ .repository_not_empty_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RepositoryNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .repository_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RepositoryPolicyNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .repository_policy_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ScanNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .scan_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SecretNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .secret_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerException")) {
        return .{ .arena = arena, .kind = .{ .server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SigningConfigurationNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .signing_configuration_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TemplateAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .template_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TemplateNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .template_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnableToAccessSecretException")) {
        return .{ .arena = arena, .kind = .{ .unable_to_access_secret_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnableToDecryptSecretValueException")) {
        return .{ .arena = arena, .kind = .{ .unable_to_decrypt_secret_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnableToGetUpstreamImageException")) {
        return .{ .arena = arena, .kind = .{ .unable_to_get_upstream_image_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnableToGetUpstreamLayerException")) {
        return .{ .arena = arena, .kind = .{ .unable_to_get_upstream_layer_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnableToListUpstreamImageReferrersException")) {
        return .{ .arena = arena, .kind = .{ .unable_to_list_upstream_image_referrers_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedImageTypeException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_image_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedUpstreamRegistryException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_upstream_registry_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UploadNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .upload_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
