const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceInput = @import("list_tags_for_resource_request.zig").ListTagsForResourceRequest;

pub const ListTagsForResourceOutput = @import("list_tags_for_resource_response.zig").ListTagsForResourceResponse;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTagsForResourceInput, options: CallOptions) !ListTagsForResourceOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListTagsForResourceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerRegistry_V20150921.ListTagsForResource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTagsForResourceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTagsForResourceOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.BlockedByOrganizationPolicyException = aws.json.parseJsonObject(errors.BlockedByOrganizationPolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .blocked_by_organization_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EmptyUploadException")) {
        const parsed_error: ?errors.EmptyUploadException = aws.json.parseJsonObject(errors.EmptyUploadException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .empty_upload_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ExclusionAlreadyExistsException")) {
        const parsed_error: ?errors.ExclusionAlreadyExistsException = aws.json.parseJsonObject(errors.ExclusionAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .exclusion_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ExclusionNotFoundException")) {
        const parsed_error: ?errors.ExclusionNotFoundException = aws.json.parseJsonObject(errors.ExclusionNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .exclusion_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ImageAlreadyExistsException")) {
        const parsed_error: ?errors.ImageAlreadyExistsException = aws.json.parseJsonObject(errors.ImageAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .image_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ImageArchivedException")) {
        const parsed_error: ?errors.ImageArchivedException = aws.json.parseJsonObject(errors.ImageArchivedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .image_archived_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ImageDigestDoesNotMatchException")) {
        const parsed_error: ?errors.ImageDigestDoesNotMatchException = aws.json.parseJsonObject(errors.ImageDigestDoesNotMatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .image_digest_does_not_match_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ImageNotFoundException")) {
        const parsed_error: ?errors.ImageNotFoundException = aws.json.parseJsonObject(errors.ImageNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .image_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ImageStorageClassUpdateNotSupportedException")) {
        const parsed_error: ?errors.ImageStorageClassUpdateNotSupportedException = aws.json.parseJsonObject(errors.ImageStorageClassUpdateNotSupportedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .image_storage_class_update_not_supported_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ImageTagAlreadyExistsException")) {
        const parsed_error: ?errors.ImageTagAlreadyExistsException = aws.json.parseJsonObject(errors.ImageTagAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .image_tag_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidLayerException")) {
        const parsed_error: ?errors.InvalidLayerException = aws.json.parseJsonObject(errors.InvalidLayerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_layer_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidLayerPartException")) {
        const parsed_error: ?errors.InvalidLayerPartException = aws.json.parseJsonObject(errors.InvalidLayerPartException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_layer_part_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        const parsed_error: ?errors.InvalidParameterException = aws.json.parseJsonObject(errors.InvalidParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTagParameterException")) {
        const parsed_error: ?errors.InvalidTagParameterException = aws.json.parseJsonObject(errors.InvalidTagParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_tag_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KmsException")) {
        const parsed_error: ?errors.KmsException = aws.json.parseJsonObject(errors.KmsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LayerAlreadyExistsException")) {
        const parsed_error: ?errors.LayerAlreadyExistsException = aws.json.parseJsonObject(errors.LayerAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .layer_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LayerInaccessibleException")) {
        const parsed_error: ?errors.LayerInaccessibleException = aws.json.parseJsonObject(errors.LayerInaccessibleException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .layer_inaccessible_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LayerPartTooSmallException")) {
        const parsed_error: ?errors.LayerPartTooSmallException = aws.json.parseJsonObject(errors.LayerPartTooSmallException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .layer_part_too_small_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LayersNotFoundException")) {
        const parsed_error: ?errors.LayersNotFoundException = aws.json.parseJsonObject(errors.LayersNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .layers_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LifecyclePolicyNotFoundException")) {
        const parsed_error: ?errors.LifecyclePolicyNotFoundException = aws.json.parseJsonObject(errors.LifecyclePolicyNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .lifecycle_policy_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LifecyclePolicyPreviewInProgressException")) {
        const parsed_error: ?errors.LifecyclePolicyPreviewInProgressException = aws.json.parseJsonObject(errors.LifecyclePolicyPreviewInProgressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .lifecycle_policy_preview_in_progress_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LifecyclePolicyPreviewNotFoundException")) {
        const parsed_error: ?errors.LifecyclePolicyPreviewNotFoundException = aws.json.parseJsonObject(errors.LifecyclePolicyPreviewNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .lifecycle_policy_preview_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PullThroughCacheRuleAlreadyExistsException")) {
        const parsed_error: ?errors.PullThroughCacheRuleAlreadyExistsException = aws.json.parseJsonObject(errors.PullThroughCacheRuleAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .pull_through_cache_rule_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PullThroughCacheRuleNotFoundException")) {
        const parsed_error: ?errors.PullThroughCacheRuleNotFoundException = aws.json.parseJsonObject(errors.PullThroughCacheRuleNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .pull_through_cache_rule_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReferencedImagesNotFoundException")) {
        const parsed_error: ?errors.ReferencedImagesNotFoundException = aws.json.parseJsonObject(errors.ReferencedImagesNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .referenced_images_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RegistryPolicyNotFoundException")) {
        const parsed_error: ?errors.RegistryPolicyNotFoundException = aws.json.parseJsonObject(errors.RegistryPolicyNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .registry_policy_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RepositoryAlreadyExistsException")) {
        const parsed_error: ?errors.RepositoryAlreadyExistsException = aws.json.parseJsonObject(errors.RepositoryAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .repository_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RepositoryNotEmptyException")) {
        const parsed_error: ?errors.RepositoryNotEmptyException = aws.json.parseJsonObject(errors.RepositoryNotEmptyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .repository_not_empty_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RepositoryNotFoundException")) {
        const parsed_error: ?errors.RepositoryNotFoundException = aws.json.parseJsonObject(errors.RepositoryNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .repository_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RepositoryPolicyNotFoundException")) {
        const parsed_error: ?errors.RepositoryPolicyNotFoundException = aws.json.parseJsonObject(errors.RepositoryPolicyNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .repository_policy_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ScanNotFoundException")) {
        const parsed_error: ?errors.ScanNotFoundException = aws.json.parseJsonObject(errors.ScanNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .scan_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SecretNotFoundException")) {
        const parsed_error: ?errors.SecretNotFoundException = aws.json.parseJsonObject(errors.SecretNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .secret_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServerException")) {
        const parsed_error: ?errors.ServerException = aws.json.parseJsonObject(errors.ServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SigningConfigurationNotFoundException")) {
        const parsed_error: ?errors.SigningConfigurationNotFoundException = aws.json.parseJsonObject(errors.SigningConfigurationNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .signing_configuration_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TemplateAlreadyExistsException")) {
        const parsed_error: ?errors.TemplateAlreadyExistsException = aws.json.parseJsonObject(errors.TemplateAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .template_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TemplateNotFoundException")) {
        const parsed_error: ?errors.TemplateNotFoundException = aws.json.parseJsonObject(errors.TemplateNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .template_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        const parsed_error: ?errors.TooManyTagsException = aws.json.parseJsonObject(errors.TooManyTagsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnableToAccessSecretException")) {
        const parsed_error: ?errors.UnableToAccessSecretException = aws.json.parseJsonObject(errors.UnableToAccessSecretException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unable_to_access_secret_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnableToDecryptSecretValueException")) {
        const parsed_error: ?errors.UnableToDecryptSecretValueException = aws.json.parseJsonObject(errors.UnableToDecryptSecretValueException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unable_to_decrypt_secret_value_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnableToGetUpstreamImageException")) {
        const parsed_error: ?errors.UnableToGetUpstreamImageException = aws.json.parseJsonObject(errors.UnableToGetUpstreamImageException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unable_to_get_upstream_image_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnableToGetUpstreamLayerException")) {
        const parsed_error: ?errors.UnableToGetUpstreamLayerException = aws.json.parseJsonObject(errors.UnableToGetUpstreamLayerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unable_to_get_upstream_layer_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnableToListUpstreamImageReferrersException")) {
        const parsed_error: ?errors.UnableToListUpstreamImageReferrersException = aws.json.parseJsonObject(errors.UnableToListUpstreamImageReferrersException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unable_to_list_upstream_image_referrers_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedImageTypeException")) {
        const parsed_error: ?errors.UnsupportedImageTypeException = aws.json.parseJsonObject(errors.UnsupportedImageTypeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_image_type_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedUpstreamRegistryException")) {
        const parsed_error: ?errors.UnsupportedUpstreamRegistryException = aws.json.parseJsonObject(errors.UnsupportedUpstreamRegistryException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_upstream_registry_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UploadNotFoundException")) {
        const parsed_error: ?errors.UploadNotFoundException = aws.json.parseJsonObject(errors.UploadNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .upload_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
