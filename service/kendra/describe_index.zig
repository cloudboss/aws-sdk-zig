const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CapacityUnitsConfiguration = @import("capacity_units_configuration.zig").CapacityUnitsConfiguration;
const DocumentMetadataConfiguration = @import("document_metadata_configuration.zig").DocumentMetadataConfiguration;
const IndexEdition = @import("index_edition.zig").IndexEdition;
const IndexStatistics = @import("index_statistics.zig").IndexStatistics;
const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;
const IndexStatus = @import("index_status.zig").IndexStatus;
const UserContextPolicy = @import("user_context_policy.zig").UserContextPolicy;
const UserGroupResolutionConfiguration = @import("user_group_resolution_configuration.zig").UserGroupResolutionConfiguration;
const UserTokenConfiguration = @import("user_token_configuration.zig").UserTokenConfiguration;

pub const DescribeIndexInput = struct {
    /// The identifier of the index you want to get information on.
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};

pub const DescribeIndexOutput = struct {
    /// For Enterprise Edition indexes, you can choose to use additional capacity to
    /// meet the
    /// needs of your application. This contains the capacity units used for the
    /// index. A query or
    /// document storage capacity of zero indicates that the index is using the
    /// default capacity. For
    /// more information on the default capacity for an index and adjusting this,
    /// see [Adjusting
    /// capacity](https://docs.aws.amazon.com/kendra/latest/dg/adjusting-capacity.html).
    capacity_units: ?CapacityUnitsConfiguration = null,

    /// The Unix timestamp when the index was created.
    created_at: ?i64 = null,

    /// The description for the index.
    description: ?[]const u8 = null,

    /// Configuration information for document metadata or fields. Document metadata
    /// are fields or
    /// attributes associated with your documents. For example, the company
    /// department name associated
    /// with each document.
    document_metadata_configurations: ?[]const DocumentMetadataConfiguration = null,

    /// The Amazon Kendra edition used for the index. You decide the edition when
    /// you create
    /// the index.
    edition: ?IndexEdition = null,

    /// When the `Status` field value is `FAILED`, the
    /// `ErrorMessage` field contains a message that explains why.
    error_message: ?[]const u8 = null,

    /// The identifier of the index.
    id: ?[]const u8 = null,

    /// Provides information about the number of FAQ questions and answers and the
    /// number of text
    /// documents indexed.
    index_statistics: ?IndexStatistics = null,

    /// The name of the index.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that gives Amazon Kendra
    /// permission to write to your Amazon CloudWatch logs.
    role_arn: ?[]const u8 = null,

    /// The identifier of the KMS customer master key (CMK) that is used to encrypt
    /// your data. Amazon Kendra doesn't support asymmetric CMKs.
    server_side_encryption_configuration: ?ServerSideEncryptionConfiguration = null,

    /// The current status of the index. When the value is `ACTIVE`, the index is
    /// ready
    /// for use. If the `Status` field value is `FAILED`, the
    /// `ErrorMessage` field contains a message that explains why.
    status: ?IndexStatus = null,

    /// The Unix timestamp when the index was last updated.
    updated_at: ?i64 = null,

    /// The user context policy for the Amazon Kendra index.
    user_context_policy: ?UserContextPolicy = null,

    /// Whether you have enabled IAM Identity Center identity source for your users
    /// and
    /// groups. This is useful for user context filtering, where search results are
    /// filtered based
    /// on the user or their group access to documents.
    user_group_resolution_configuration: ?UserGroupResolutionConfiguration = null,

    /// The user token configuration for the Amazon Kendra index.
    user_token_configurations: ?[]const UserTokenConfiguration = null,

    pub const json_field_names = .{
        .capacity_units = "CapacityUnits",
        .created_at = "CreatedAt",
        .description = "Description",
        .document_metadata_configurations = "DocumentMetadataConfigurations",
        .edition = "Edition",
        .error_message = "ErrorMessage",
        .id = "Id",
        .index_statistics = "IndexStatistics",
        .name = "Name",
        .role_arn = "RoleArn",
        .server_side_encryption_configuration = "ServerSideEncryptionConfiguration",
        .status = "Status",
        .updated_at = "UpdatedAt",
        .user_context_policy = "UserContextPolicy",
        .user_group_resolution_configuration = "UserGroupResolutionConfiguration",
        .user_token_configurations = "UserTokenConfigurations",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeIndexInput, options: Options) !DescribeIndexOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeIndexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.DescribeIndex");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeIndexOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeIndexOutput, body, allocator);
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
