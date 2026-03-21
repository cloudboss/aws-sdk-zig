const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const InferenceComponentSortKey = @import("inference_component_sort_key.zig").InferenceComponentSortKey;
const OrderKey = @import("order_key.zig").OrderKey;
const InferenceComponentStatus = @import("inference_component_status.zig").InferenceComponentStatus;
const InferenceComponentSummary = @import("inference_component_summary.zig").InferenceComponentSummary;

pub const ListInferenceComponentsInput = struct {
    /// Filters the results to only those inference components that were created
    /// after the specified time.
    creation_time_after: ?i64 = null,

    /// Filters the results to only those inference components that were created
    /// before the specified time.
    creation_time_before: ?i64 = null,

    /// An endpoint name to filter the listed inference components. The response
    /// includes only those inference components that are hosted at the specified
    /// endpoint.
    endpoint_name_equals: ?[]const u8 = null,

    /// Filters the results to only those inference components that were updated
    /// after the specified time.
    last_modified_time_after: ?i64 = null,

    /// Filters the results to only those inference components that were updated
    /// before the specified time.
    last_modified_time_before: ?i64 = null,

    /// The maximum number of inference components to return in the response. This
    /// value defaults to 10.
    max_results: ?i32 = null,

    /// Filters the results to only those inference components with a name that
    /// contains the specified string.
    name_contains: ?[]const u8 = null,

    /// A token that you use to get the next set of results following a truncated
    /// response. If the response to the previous request was truncated, that
    /// response provides the value for this token.
    next_token: ?[]const u8 = null,

    /// The field by which to sort the inference components in the response. The
    /// default is `CreationTime`.
    sort_by: ?InferenceComponentSortKey = null,

    /// The sort order for results. The default is `Descending`.
    sort_order: ?OrderKey = null,

    /// Filters the results to only those inference components with the specified
    /// status.
    status_equals: ?InferenceComponentStatus = null,

    /// A production variant name to filter the listed inference components. The
    /// response includes only those inference components that are hosted at the
    /// specified variant.
    variant_name_equals: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .endpoint_name_equals = "EndpointNameEquals",
        .last_modified_time_after = "LastModifiedTimeAfter",
        .last_modified_time_before = "LastModifiedTimeBefore",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .status_equals = "StatusEquals",
        .variant_name_equals = "VariantNameEquals",
    };
};

pub const ListInferenceComponentsOutput = struct {
    /// A list of inference components and their properties that matches any of the
    /// filters you specified in the request.
    inference_components: ?[]const InferenceComponentSummary = null,

    /// The token to use in a subsequent request to get the next set of results
    /// following a truncated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .inference_components = "InferenceComponents",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInferenceComponentsInput, options: CallOptions) !ListInferenceComponentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInferenceComponentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListInferenceComponents");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInferenceComponentsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListInferenceComponentsOutput, body, allocator);
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
