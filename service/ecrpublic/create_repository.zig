const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const RepositoryCatalogDataInput = @import("repository_catalog_data_input.zig").RepositoryCatalogDataInput;
const Tag = @import("tag.zig").Tag;
const RepositoryCatalogData = @import("repository_catalog_data.zig").RepositoryCatalogData;
const Repository = @import("repository.zig").Repository;

pub const CreateRepositoryInput = struct {
    /// The details about the repository that are publicly visible in the
    /// Amazon ECR Public Gallery.
    catalog_data: ?RepositoryCatalogDataInput = null,

    /// The name to use for the repository. This appears publicly in the Amazon ECR
    /// Public Gallery.
    /// The repository name can be specified on its own (for example
    /// `nginx-web-app`) or
    /// prepended with a namespace to group the repository into a category (for
    /// example
    /// `project-a/nginx-web-app`).
    repository_name: []const u8,

    /// The metadata that you apply to each repository to help categorize and
    /// organize your
    /// repositories. Each tag consists of a key and an optional value. You define
    /// both of them.
    /// Tag keys can have a maximum character length of 128 characters, and tag
    /// values can have a maximum length of 256 characters.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .catalog_data = "catalogData",
        .repository_name = "repositoryName",
        .tags = "tags",
    };
};

pub const CreateRepositoryOutput = struct {
    catalog_data: ?RepositoryCatalogData = null,

    /// The repository that was created.
    repository: ?Repository = null,

    pub const json_field_names = .{
        .catalog_data = "catalogData",
        .repository = "repository",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRepositoryInput, options: CallOptions) !CreateRepositoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ecr-public");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRepositoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.ecr-public", "ECR PUBLIC", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SpencerFrontendService.CreateRepository");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRepositoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateRepositoryOutput, body, allocator);
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
