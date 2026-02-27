const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CapacityUnitsConfiguration = @import("capacity_units_configuration.zig").CapacityUnitsConfiguration;
const DocumentMetadataConfiguration = @import("document_metadata_configuration.zig").DocumentMetadataConfiguration;
const UserContextPolicy = @import("user_context_policy.zig").UserContextPolicy;
const UserGroupResolutionConfiguration = @import("user_group_resolution_configuration.zig").UserGroupResolutionConfiguration;
const UserTokenConfiguration = @import("user_token_configuration.zig").UserTokenConfiguration;

pub const UpdateIndexInput = struct {
    /// Sets the number of additional document storage and query capacity units that
    /// should be
    /// used by the index. You can change the capacity of the index up to 5 times
    /// per day, or make 5
    /// API calls.
    ///
    /// If you are using extra storage units, you can't reduce the storage capacity
    /// below what is
    /// required to meet the storage needs for your index.
    capacity_units: ?CapacityUnitsConfiguration = null,

    /// A new description for the index.
    description: ?[]const u8 = null,

    /// The document metadata configuration you want to update for the index.
    /// Document metadata
    /// are fields or attributes associated with your documents. For example, the
    /// company department
    /// name associated with each document.
    document_metadata_configuration_updates: ?[]const DocumentMetadataConfiguration = null,

    /// The identifier of the index you want to update.
    id: []const u8,

    /// A new name for the index.
    name: ?[]const u8 = null,

    /// An Identity and Access Management (IAM) role that gives Amazon Kendra
    /// permission to access Amazon CloudWatch logs and metrics.
    role_arn: ?[]const u8 = null,

    /// The user context policy.
    ///
    /// If you're using an Amazon Kendra Gen AI Enterprise Edition index, you can
    /// only use
    /// `ATTRIBUTE_FILTER` to filter search results by user context. If you're
    /// using an Amazon Kendra Gen AI Enterprise Edition index and you try to use
    /// `USER_TOKEN` to configure user context policy, Amazon Kendra returns a
    /// `ValidationException` error.
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
        .capacity_units = "CapacityUnits",
        .description = "Description",
        .document_metadata_configuration_updates = "DocumentMetadataConfigurationUpdates",
        .id = "Id",
        .name = "Name",
        .role_arn = "RoleArn",
        .user_context_policy = "UserContextPolicy",
        .user_group_resolution_configuration = "UserGroupResolutionConfiguration",
        .user_token_configurations = "UserTokenConfigurations",
    };
};

const UpdateIndexOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateIndexInput, options: Options) !UpdateIndexOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateIndexInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AWSKendraFrontendService.UpdateIndex");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateIndexOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    return .{};
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
