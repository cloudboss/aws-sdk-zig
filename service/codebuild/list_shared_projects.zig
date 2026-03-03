const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const SharedResourceSortByType = @import("shared_resource_sort_by_type.zig").SharedResourceSortByType;
const SortOrderType = @import("sort_order_type.zig").SortOrderType;

pub const ListSharedProjectsInput = struct {
    /// The maximum number of paginated shared build projects returned per response.
    /// Use
    /// `nextToken` to iterate pages in the list of returned `Project`
    /// objects. The default value is 100.
    max_results: ?i32 = null,

    /// During a previous call, the maximum number of items that can be returned is
    /// the value
    /// specified in `maxResults`. If there more items in the list, then a unique
    /// string called a *nextToken* is returned. To get the next batch of
    /// items in the list, call this operation again, adding the next token to the
    /// call. To get
    /// all of the items in the list, keep calling this operation with each
    /// subsequent next
    /// token that is returned, until no more next tokens are returned.
    next_token: ?[]const u8 = null,

    /// The criterion to be used to list build projects shared with the current
    /// Amazon Web Services account
    /// or user. Valid values include:
    ///
    /// * `ARN`: List based on the ARN.
    ///
    /// * `MODIFIED_TIME`: List based on when information about the shared
    /// project was last changed.
    sort_by: ?SharedResourceSortByType = null,

    /// The order in which to list shared build projects. Valid values include:
    ///
    /// * `ASCENDING`: List in ascending order.
    ///
    /// * `DESCENDING`: List in descending order.
    sort_order: ?SortOrderType = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};

pub const ListSharedProjectsOutput = struct {
    /// During a previous call, the maximum number of items that can be returned is
    /// the value
    /// specified in `maxResults`. If there more items in the list, then a unique
    /// string called a *nextToken* is returned. To get the next batch of
    /// items in the list, call this operation again, adding the next token to the
    /// call. To get
    /// all of the items in the list, keep calling this operation with each
    /// subsequent next
    /// token that is returned, until no more next tokens are returned.
    next_token: ?[]const u8 = null,

    /// The list of ARNs for the build projects shared with the current Amazon Web
    /// Services account or user.
    projects: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .projects = "projects",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSharedProjectsInput, options: CallOptions) !ListSharedProjectsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "codebuild");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSharedProjectsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codebuild", "CodeBuild", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "CodeBuild_20161006.ListSharedProjects");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSharedProjectsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListSharedProjectsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccountLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .account_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountSuspendedException")) {
        return .{ .arena = arena, .kind = .{ .account_suspended_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OAuthProviderException")) {
        return .{ .arena = arena, .kind = .{ .o_auth_provider_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
