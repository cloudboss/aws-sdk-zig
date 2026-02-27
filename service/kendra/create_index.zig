const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IndexEdition = @import("index_edition.zig").IndexEdition;
const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;
const Tag = @import("tag.zig").Tag;
const UserContextPolicy = @import("user_context_policy.zig").UserContextPolicy;
const UserGroupResolutionConfiguration = @import("user_group_resolution_configuration.zig").UserGroupResolutionConfiguration;
const UserTokenConfiguration = @import("user_token_configuration.zig").UserTokenConfiguration;

pub const CreateIndexInput = struct {
    /// A token that you provide to identify the request to create an index.
    /// Multiple calls to the
    /// `CreateIndex` API with the same client token will create only one index.
    client_token: ?[]const u8 = null,

    /// A description for the index.
    description: ?[]const u8 = null,

    /// The Amazon Kendra edition to use for the index. Choose `DEVELOPER_EDITION`
    /// for indexes intended for development, testing, or proof of concept. Use
    /// `ENTERPRISE_EDITION` for production. Use `GEN_AI_ENTERPRISE_EDITION`
    /// for creating generative AI applications. Once you set the edition for an
    /// index, it can't be
    /// changed.
    ///
    /// The `Edition` parameter is optional. If you don't supply a value, the
    /// default
    /// is `ENTERPRISE_EDITION`.
    ///
    /// For more information on quota limits for Gen AI Enterprise Edition,
    /// Enterprise Edition, and
    /// Developer Edition indices, see
    /// [Quotas](https://docs.aws.amazon.com/kendra/latest/dg/quotas.html).
    edition: ?IndexEdition = null,

    /// A name for the index.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of an IAM role with permission to access
    /// your Amazon CloudWatch logs and metrics. For more information, see [IAM
    /// access roles
    /// for Amazon
    /// Kendra](https://docs.aws.amazon.com/kendra/latest/dg/iam-roles.html).
    role_arn: []const u8,

    /// The identifier of the KMS customer managed key (CMK) that's used to encrypt
    /// data indexed by Amazon Kendra. Amazon Kendra doesn't support asymmetric
    /// CMKs.
    server_side_encryption_configuration: ?ServerSideEncryptionConfiguration = null,

    /// A list of key-value pairs that identify or categorize the index. You can
    /// also use tags to
    /// help control access to the index. Tag keys and values can consist of Unicode
    /// letters, digits,
    /// white space, and any of the following symbols: _ . : / = + - @.
    tags: ?[]const Tag = null,

    /// The user context policy.
    ///
    /// If you're using an Amazon Kendra Gen AI Enterprise Edition index, you can
    /// only use
    /// `ATTRIBUTE_FILTER` to filter search results by user context. If you're
    /// using an Amazon Kendra Gen AI Enterprise Edition index and you try to use
    /// `USER_TOKEN` to configure user context policy, Amazon Kendra returns a
    /// `ValidationException` error.
    ///
    /// **ATTRIBUTE_FILTER**
    ///
    /// All indexed content is searchable and displayable for all users. If you want
    /// to
    /// filter search results on user context, you can use the attribute filters of
    /// `_user_id` and `_group_ids` or you can provide user and
    /// group information in `UserContext`.
    ///
    /// **USER_TOKEN**
    ///
    /// Enables token-based user access control to filter search results on user
    /// context. All documents with no access control and all documents accessible
    /// to the
    /// user will be searchable and displayable.
    user_context_policy: ?UserContextPolicy = null,

    /// Gets users and groups from IAM Identity Center identity source. To configure
    /// this,
    /// see
    /// [UserGroupResolutionConfiguration](https://docs.aws.amazon.com/kendra/latest/dg/API_UserGroupResolutionConfiguration.html). This is useful for user context filtering,
    /// where search results are filtered based on the user or their group access to
    /// documents.
    ///
    /// If you're using an Amazon Kendra Gen AI Enterprise Edition index,
    /// `UserGroupResolutionConfiguration` isn't supported.
    user_group_resolution_configuration: ?UserGroupResolutionConfiguration = null,

    /// The user token configuration.
    ///
    /// If you're using an Amazon Kendra Gen AI Enterprise Edition index and you try
    /// to use
    /// `UserTokenConfigurations` to configure user context policy, Amazon Kendra
    /// returns
    /// a `ValidationException` error.
    user_token_configurations: ?[]const UserTokenConfiguration = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .edition = "Edition",
        .name = "Name",
        .role_arn = "RoleArn",
        .server_side_encryption_configuration = "ServerSideEncryptionConfiguration",
        .tags = "Tags",
        .user_context_policy = "UserContextPolicy",
        .user_group_resolution_configuration = "UserGroupResolutionConfiguration",
        .user_token_configurations = "UserTokenConfigurations",
    };
};

pub const CreateIndexOutput = struct {
    /// The identifier of the index. Use this identifier when you query an index,
    /// set up a data
    /// source, or index a document.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIndexInput, options: Options) !CreateIndexOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "kendra");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateIndexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AWSKendraFrontendService.CreateIndex");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateIndexOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateIndexOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FeaturedResultsConflictException")) {
        return .{ .arena = arena, .kind = .{ .featured_results_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .resource_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
