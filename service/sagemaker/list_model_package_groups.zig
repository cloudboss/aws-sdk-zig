const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CrossAccountFilterOption = @import("cross_account_filter_option.zig").CrossAccountFilterOption;
const ModelPackageGroupSortBy = @import("model_package_group_sort_by.zig").ModelPackageGroupSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const ModelPackageGroupSummary = @import("model_package_group_summary.zig").ModelPackageGroupSummary;

pub const ListModelPackageGroupsInput = struct {
    /// A filter that returns only model groups created after the specified time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only model groups created before the specified time.
    creation_time_before: ?i64 = null,

    /// A filter that returns either model groups shared with you or model groups in
    /// your own account. When the value is `CrossAccount`, the results show the
    /// resources made discoverable to you from other accounts. When the value is
    /// `SameAccount` or `null`, the results show resources from your account. The
    /// default is `SameAccount`.
    cross_account_filter_option: ?CrossAccountFilterOption = null,

    /// The maximum number of results to return in the response.
    max_results: ?i32 = null,

    /// A string in the model group name. This filter returns only model groups
    /// whose name contains the specified string.
    name_contains: ?[]const u8 = null,

    /// If the result of the previous `ListModelPackageGroups` request was
    /// truncated, the response includes a `NextToken`. To retrieve the next set of
    /// model groups, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// The field to sort results by. The default is `CreationTime`.
    sort_by: ?ModelPackageGroupSortBy = null,

    /// The sort order for results. The default is `Ascending`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .cross_account_filter_option = "CrossAccountFilterOption",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListModelPackageGroupsOutput = struct {
    /// A list of summaries of the model groups in your Amazon Web Services account.
    model_package_group_summary_list: ?[]const ModelPackageGroupSummary = null,

    /// If the response is truncated, SageMaker returns this token. To retrieve the
    /// next set of model groups, use it in the subsequent request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_package_group_summary_list = "ModelPackageGroupSummaryList",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListModelPackageGroupsInput, options: Options) !ListModelPackageGroupsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListModelPackageGroupsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListModelPackageGroups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListModelPackageGroupsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListModelPackageGroupsOutput, body, allocator);
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
