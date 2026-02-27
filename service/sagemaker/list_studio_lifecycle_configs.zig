const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const StudioLifecycleConfigAppType = @import("studio_lifecycle_config_app_type.zig").StudioLifecycleConfigAppType;
const StudioLifecycleConfigSortKey = @import("studio_lifecycle_config_sort_key.zig").StudioLifecycleConfigSortKey;
const SortOrder = @import("sort_order.zig").SortOrder;
const StudioLifecycleConfigDetails = @import("studio_lifecycle_config_details.zig").StudioLifecycleConfigDetails;

pub const ListStudioLifecycleConfigsInput = struct {
    /// A parameter to search for the App Type to which the Lifecycle Configuration
    /// is attached.
    app_type_equals: ?StudioLifecycleConfigAppType = null,

    /// A filter that returns only Lifecycle Configurations created on or after the
    /// specified time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only Lifecycle Configurations created on or before the
    /// specified time.
    creation_time_before: ?i64 = null,

    /// The total number of items to return in the response. If the total number of
    /// items available is more than the value specified, a `NextToken` is provided
    /// in the response. To resume pagination, provide the `NextToken` value in the
    /// as part of a subsequent call. The default value is 10.
    max_results: ?i32 = null,

    /// A filter that returns only Lifecycle Configurations modified after the
    /// specified time.
    modified_time_after: ?i64 = null,

    /// A filter that returns only Lifecycle Configurations modified before the
    /// specified time.
    modified_time_before: ?i64 = null,

    /// A string in the Lifecycle Configuration name. This filter returns only
    /// Lifecycle Configurations whose name contains the specified string.
    name_contains: ?[]const u8 = null,

    /// If the previous call to ListStudioLifecycleConfigs didn't return the full
    /// set of Lifecycle Configurations, the call returns a token for getting the
    /// next set of Lifecycle Configurations.
    next_token: ?[]const u8 = null,

    /// The property used to sort results. The default value is CreationTime.
    sort_by: ?StudioLifecycleConfigSortKey = null,

    /// The sort order. The default value is Descending.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .app_type_equals = "AppTypeEquals",
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .max_results = "MaxResults",
        .modified_time_after = "ModifiedTimeAfter",
        .modified_time_before = "ModifiedTimeBefore",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListStudioLifecycleConfigsOutput = struct {
    /// If the previous response was truncated, you will receive this token. Use it
    /// in your next request to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// A list of Lifecycle Configurations and their properties.
    studio_lifecycle_configs: ?[]const StudioLifecycleConfigDetails = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .studio_lifecycle_configs = "StudioLifecycleConfigs",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStudioLifecycleConfigsInput, options: Options) !ListStudioLifecycleConfigsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ListStudioLifecycleConfigsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.ListStudioLifecycleConfigs");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListStudioLifecycleConfigsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListStudioLifecycleConfigsOutput, body, alloc);
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
