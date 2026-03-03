const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ImageIdentifier = @import("image_identifier.zig").ImageIdentifier;
const ImageFailure = @import("image_failure.zig").ImageFailure;

pub const BatchDeleteImageInput = struct {
    /// A list of image ID references that correspond to images to delete. The
    /// format of the
    /// `imageIds` reference is `imageTag=tag` or
    /// `imageDigest=digest`.
    image_ids: []const ImageIdentifier,

    /// The Amazon Web Services account ID, or registry alias, that's associated
    /// with the registry that
    /// contains the image to delete. If you do not specify a registry, the default
    /// public registry is assumed.
    registry_id: ?[]const u8 = null,

    /// The repository in a public registry that contains the image to delete.
    repository_name: []const u8,

    pub const json_field_names = .{
        .image_ids = "imageIds",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};

pub const BatchDeleteImageOutput = struct {
    /// Any failures associated with the call.
    failures: ?[]const ImageFailure = null,

    /// The image IDs of the deleted images.
    image_ids: ?[]const ImageIdentifier = null,

    pub const json_field_names = .{
        .failures = "failures",
        .image_ids = "imageIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDeleteImageInput, options: CallOptions) !BatchDeleteImageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ecrpublic");

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDeleteImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecrpublic", "ECR PUBLIC", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SpencerFrontendService.BatchDeleteImage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDeleteImageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchDeleteImageOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "EmptyUploadException")) {
        return .{ .arena = arena, .kind = .{ .empty_upload_exception = .{
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
    if (std.mem.eql(u8, error_code, "LayerAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .layer_already_exists_exception = .{
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
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "RegistryNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .registry_not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "RepositoryCatalogDataNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .repository_catalog_data_not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServerException")) {
        return .{ .arena = arena, .kind = .{ .server_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnsupportedCommandException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_command_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
