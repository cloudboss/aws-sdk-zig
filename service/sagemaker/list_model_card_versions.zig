const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ModelCardStatus = @import("model_card_status.zig").ModelCardStatus;
const ModelCardVersionSortBy = @import("model_card_version_sort_by.zig").ModelCardVersionSortBy;
const ModelCardSortOrder = @import("model_card_sort_order.zig").ModelCardSortOrder;
const ModelCardVersionSummary = @import("model_card_version_summary.zig").ModelCardVersionSummary;

pub const ListModelCardVersionsInput = struct {
    /// Only list model card versions that were created after the time specified.
    creation_time_after: ?i64 = null,

    /// Only list model card versions that were created before the time specified.
    creation_time_before: ?i64 = null,

    /// The maximum number of model card versions to list.
    max_results: ?i32 = null,

    /// List model card versions for the model card with the specified name or
    /// Amazon Resource Name (ARN).
    model_card_name: []const u8,

    /// Only list model card versions with the specified approval status.
    model_card_status: ?ModelCardStatus = null,

    /// If the response to a previous `ListModelCardVersions` request was truncated,
    /// the response includes a `NextToken`. To retrieve the next set of model card
    /// versions, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// Sort listed model card versions by version. Sorts by version by default.
    sort_by: ?ModelCardVersionSortBy = null,

    /// Sort model card versions by ascending or descending order.
    sort_order: ?ModelCardSortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .max_results = "MaxResults",
        .model_card_name = "ModelCardName",
        .model_card_status = "ModelCardStatus",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListModelCardVersionsOutput = struct {
    /// The summaries of the listed versions of the model card.
    model_card_version_summary_list: ?[]const ModelCardVersionSummary = null,

    /// If the response is truncated, SageMaker returns this token. To retrieve the
    /// next set of model card versions, use it in the subsequent request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_card_version_summary_list = "ModelCardVersionSummaryList",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListModelCardVersionsInput, options: Options) !ListModelCardVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListModelCardVersionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListModelCardVersions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListModelCardVersionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListModelCardVersionsOutput, body, allocator);
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
