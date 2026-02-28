const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CodeRepositorySortBy = @import("code_repository_sort_by.zig").CodeRepositorySortBy;
const CodeRepositorySortOrder = @import("code_repository_sort_order.zig").CodeRepositorySortOrder;
const CodeRepositorySummary = @import("code_repository_summary.zig").CodeRepositorySummary;

pub const ListCodeRepositoriesInput = struct {
    /// A filter that returns only Git repositories that were created after the
    /// specified time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only Git repositories that were created before the
    /// specified time.
    creation_time_before: ?i64 = null,

    /// A filter that returns only Git repositories that were last modified after
    /// the specified time.
    last_modified_time_after: ?i64 = null,

    /// A filter that returns only Git repositories that were last modified before
    /// the specified time.
    last_modified_time_before: ?i64 = null,

    /// The maximum number of Git repositories to return in the response.
    max_results: ?i32 = null,

    /// A string in the Git repositories name. This filter returns only repositories
    /// whose name contains the specified string.
    name_contains: ?[]const u8 = null,

    /// If the result of a `ListCodeRepositoriesOutput` request was truncated, the
    /// response includes a `NextToken`. To get the next set of Git repositories,
    /// use the token in the next request.
    next_token: ?[]const u8 = null,

    /// The field to sort results by. The default is `Name`.
    sort_by: ?CodeRepositorySortBy = null,

    /// The sort order for results. The default is `Ascending`.
    sort_order: ?CodeRepositorySortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .last_modified_time_after = "LastModifiedTimeAfter",
        .last_modified_time_before = "LastModifiedTimeBefore",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListCodeRepositoriesOutput = struct {
    /// Gets a list of summaries of the Git repositories. Each summary specifies the
    /// following values for the repository:
    ///
    /// * Name
    /// * Amazon Resource Name (ARN)
    /// * Creation time
    /// * Last modified time
    /// * Configuration information, including the URL location of the repository
    ///   and the ARN of the Amazon Web Services Secrets Manager secret that
    ///   contains the credentials used to access the repository.
    code_repository_summary_list: ?[]const CodeRepositorySummary = null,

    /// If the result of a `ListCodeRepositoriesOutput` request was truncated, the
    /// response includes a `NextToken`. To get the next set of Git repositories,
    /// use the token in the next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .code_repository_summary_list = "CodeRepositorySummaryList",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCodeRepositoriesInput, options: Options) !ListCodeRepositoriesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(alloc: std.mem.Allocator, input: ListCodeRepositoriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.ListCodeRepositories");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListCodeRepositoriesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListCodeRepositoriesOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
