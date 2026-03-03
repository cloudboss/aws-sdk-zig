const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const NotebookInstanceSortKey = @import("notebook_instance_sort_key.zig").NotebookInstanceSortKey;
const NotebookInstanceSortOrder = @import("notebook_instance_sort_order.zig").NotebookInstanceSortOrder;
const NotebookInstanceStatus = @import("notebook_instance_status.zig").NotebookInstanceStatus;
const NotebookInstanceSummary = @import("notebook_instance_summary.zig").NotebookInstanceSummary;

pub const ListNotebookInstancesInput = struct {
    /// A filter that returns only notebook instances with associated with the
    /// specified git repository.
    additional_code_repository_equals: ?[]const u8 = null,

    /// A filter that returns only notebook instances that were created after the
    /// specified time (timestamp).
    creation_time_after: ?i64 = null,

    /// A filter that returns only notebook instances that were created before the
    /// specified time (timestamp).
    creation_time_before: ?i64 = null,

    /// A string in the name or URL of a Git repository associated with this
    /// notebook instance. This filter returns only notebook instances associated
    /// with a git repository with a name that contains the specified string.
    default_code_repository_contains: ?[]const u8 = null,

    /// A filter that returns only notebook instances that were modified after the
    /// specified time (timestamp).
    last_modified_time_after: ?i64 = null,

    /// A filter that returns only notebook instances that were modified before the
    /// specified time (timestamp).
    last_modified_time_before: ?i64 = null,

    /// The maximum number of notebook instances to return.
    max_results: ?i32 = null,

    /// A string in the notebook instances' name. This filter returns only notebook
    /// instances whose name contains the specified string.
    name_contains: ?[]const u8 = null,

    /// If the previous call to the `ListNotebookInstances` is truncated, the
    /// response includes a `NextToken`. You can use this token in your subsequent
    /// `ListNotebookInstances` request to fetch the next set of notebook instances.
    ///
    /// You might specify a filter or a sort order in your request. When response is
    /// truncated, you must use the same values for the filer and sort order in the
    /// next request.
    next_token: ?[]const u8 = null,

    /// A string in the name of a notebook instances lifecycle configuration
    /// associated with this notebook instance. This filter returns only notebook
    /// instances associated with a lifecycle configuration with a name that
    /// contains the specified string.
    notebook_instance_lifecycle_config_name_contains: ?[]const u8 = null,

    /// The field to sort results by. The default is `Name`.
    sort_by: ?NotebookInstanceSortKey = null,

    /// The sort order for results.
    sort_order: ?NotebookInstanceSortOrder = null,

    /// A filter that returns only notebook instances with the specified status.
    status_equals: ?NotebookInstanceStatus = null,

    pub const json_field_names = .{
        .additional_code_repository_equals = "AdditionalCodeRepositoryEquals",
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .default_code_repository_contains = "DefaultCodeRepositoryContains",
        .last_modified_time_after = "LastModifiedTimeAfter",
        .last_modified_time_before = "LastModifiedTimeBefore",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .notebook_instance_lifecycle_config_name_contains = "NotebookInstanceLifecycleConfigNameContains",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .status_equals = "StatusEquals",
    };
};

pub const ListNotebookInstancesOutput = struct {
    /// If the response to the previous `ListNotebookInstances` request was
    /// truncated, SageMaker AI returns this token. To retrieve the next set of
    /// notebook instances, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// An array of `NotebookInstanceSummary` objects, one for each notebook
    /// instance.
    notebook_instances: ?[]const NotebookInstanceSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .notebook_instances = "NotebookInstances",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListNotebookInstancesInput, options: CallOptions) !ListNotebookInstancesOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListNotebookInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListNotebookInstances");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListNotebookInstancesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListNotebookInstancesOutput, body, allocator);
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
