const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const GroupMembers = @import("group_members.zig").GroupMembers;

pub const PutPrincipalMappingInput = struct {
    /// The identifier of the data source you want to map users to their groups.
    ///
    /// This is useful if a group is tied to multiple data sources, but you only
    /// want the
    /// group to access documents of a certain data source. For example, the groups
    /// "Research",
    /// "Engineering", and "Sales and Marketing" are all tied to the company's
    /// documents stored
    /// in the data sources Confluence and Salesforce. However, "Sales and
    /// Marketing" team only
    /// needs access to customer-related documents stored in Salesforce.
    data_source_id: ?[]const u8 = null,

    /// The identifier of the group you want to map its users to.
    group_id: []const u8,

    /// The list that contains your users that belong the same group. This can
    /// include sub groups
    /// that belong to a group.
    ///
    /// For example, the group "Company A" includes the user "CEO" and the sub
    /// groups
    /// "Research", "Engineering", and "Sales and Marketing".
    ///
    /// If you have more than 1000 users and/or sub groups for a single group, you
    /// need to
    /// provide the path to the S3 file that lists your users and sub groups for a
    /// group. Your
    /// sub groups can contain more than 1000 users, but the list of sub groups that
    /// belong to a
    /// group (and/or users) must be no more than 1000.
    group_members: GroupMembers,

    /// The identifier of the index you want to map users to their groups.
    index_id: []const u8,

    /// The timestamp identifier you specify to ensure Amazon Kendra doesn't
    /// override
    /// the latest `PUT` action with previous actions. The highest number ID, which
    /// is the ordering ID, is the latest action you want to process and apply on
    /// top of other
    /// actions with lower number IDs. This prevents previous actions with lower
    /// number IDs from
    /// possibly overriding the latest action.
    ///
    /// The ordering ID can be the Unix time of the last update you made to a group
    /// members
    /// list. You would then provide this list when calling `PutPrincipalMapping`.
    /// This ensures your `PUT` action for that updated group with the latest
    /// members
    /// list doesn't get overwritten by earlier `PUT` actions for the same group
    /// which are yet to be processed.
    ///
    /// The default ordering ID is the current Unix time in milliseconds that the
    /// action was
    /// received by Amazon Kendra.
    ordering_id: ?i64 = null,

    /// The Amazon Resource Name (ARN) of an IAM role that has access to the
    /// S3 file that contains your list of users that belong to a group.
    ///
    /// For more information, see [IAM roles for
    /// Amazon
    /// Kendra](https://docs.aws.amazon.com/kendra/latest/dg/iam-roles.html#iam-roles-ds).
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_source_id = "DataSourceId",
        .group_id = "GroupId",
        .group_members = "GroupMembers",
        .index_id = "IndexId",
        .ordering_id = "OrderingId",
        .role_arn = "RoleArn",
    };
};

const PutPrincipalMappingOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutPrincipalMappingInput, options: Options) !PutPrincipalMappingOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: PutPrincipalMappingInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AWSKendraFrontendService.PutPrincipalMapping");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutPrincipalMappingOutput {
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
