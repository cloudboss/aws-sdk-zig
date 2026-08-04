const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const ImageTagDetail = @import("image_tag_detail.zig").ImageTagDetail;

pub const DescribeImageTagsInput = struct {
    /// The maximum number of repository results that's returned by
    /// `DescribeImageTags` in paginated output. When this parameter is used,
    /// `DescribeImageTags` only returns `maxResults` results in a single
    /// page along with a `nextToken` response element. You can see the remaining
    /// results of the initial request by sending another `DescribeImageTags`
    /// request
    /// with the returned `nextToken` value. This value can be between 1
    /// and 1000. If this parameter isn't used, then `DescribeImageTags`
    /// returns up to 100 results and a `nextToken` value, if
    /// applicable. If you specify images with `imageIds`, you can't use this
    /// option.
    max_results: ?i32 = null,

    /// The `nextToken` value that's returned from a previous paginated
    /// `DescribeImageTags` request where `maxResults` was used and the
    /// results exceeded the value of that parameter. Pagination continues from the
    /// end of the
    /// previous results that returned the `nextToken` value. If there are no more
    /// results to return, this value is `null`. If you specify images with
    /// `imageIds`, you can't use this option.
    next_token: ?[]const u8 = null,

    /// The Amazon Web Services account ID that's associated with the public
    /// registry that contains the
    /// repository where images are described. If you do not specify a registry, the
    /// default public registry is assumed.
    registry_id: ?[]const u8 = null,

    /// The name of the repository that contains the image tag details to describe.
    repository_name: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};

pub const DescribeImageTagsOutput = struct {
    /// The image tag details for the images in the requested repository.
    image_tag_details: ?[]const ImageTagDetail = null,

    /// The `nextToken` value to include in a future `DescribeImageTags`
    /// request. When the results of a `DescribeImageTags` request exceed
    /// `maxResults`, you can use this value to retrieve the next page of results.
    /// If
    /// there are no more results to return, this value is `null`.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_tag_details = "imageTagDetails",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeImageTagsInput, options: CallOptions) !DescribeImageTagsOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeImageTagsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SpencerFrontendService.DescribeImageTags");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeImageTagsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeImageTagsOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "RegistryNotFoundException")) {
        const parsed_error: ?errors.RegistryNotFoundException = aws.json.parseJsonObject(errors.RegistryNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .registry_not_found_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "RepositoryCatalogDataNotFoundException")) {
        const parsed_error: ?errors.RepositoryCatalogDataNotFoundException = aws.json.parseJsonObject(errors.RepositoryCatalogDataNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .repository_catalog_data_not_found_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "UnsupportedCommandException")) {
        const parsed_error: ?errors.UnsupportedCommandException = aws.json.parseJsonObject(errors.UnsupportedCommandException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_command_exception = typed_error } };
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
