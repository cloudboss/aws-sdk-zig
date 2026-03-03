const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ClusterSortBy = @import("cluster_sort_by.zig").ClusterSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const ClusterSummary = @import("cluster_summary.zig").ClusterSummary;

pub const ListClustersInput = struct {
    /// Set a start time for the time range during which you want to list SageMaker
    /// HyperPod clusters. Timestamps are formatted according to the ISO 8601
    /// standard.
    ///
    /// Acceptable formats include:
    ///
    /// * `YYYY-MM-DDThh:mm:ss.sssTZD` (UTC), for example,
    ///   `2014-10-01T20:30:00.000Z`
    /// * `YYYY-MM-DDThh:mm:ss.sssTZD` (with offset), for example,
    ///   `2014-10-01T12:30:00.000-08:00`
    /// * `YYYY-MM-DD`, for example, `2014-10-01`
    /// * Unix time in seconds, for example, `1412195400`. This is also referred to
    ///   as Unix Epoch time and represents the number of seconds since midnight,
    ///   January 1, 1970 UTC.
    ///
    /// For more information about the timestamp format, see
    /// [Timestamp](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-parameters-types.html#parameter-type-timestamp) in the *Amazon Web Services Command Line Interface User Guide*.
    creation_time_after: ?i64 = null,

    /// Set an end time for the time range during which you want to list SageMaker
    /// HyperPod clusters. A filter that returns nodes in a SageMaker HyperPod
    /// cluster created before the specified time. The acceptable formats are the
    /// same as the timestamp formats for `CreationTimeAfter`. For more information
    /// about the timestamp format, see
    /// [Timestamp](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-parameters-types.html#parameter-type-timestamp) in the *Amazon Web Services Command Line Interface User Guide*.
    creation_time_before: ?i64 = null,

    /// Specifies the maximum number of clusters to evaluate for the operation (not
    /// necessarily the number of matching items). After SageMaker processes the
    /// number of clusters up to `MaxResults`, it stops the operation and returns
    /// the matching clusters up to that point. If all the matching clusters are
    /// desired, SageMaker will go through all the clusters until `NextToken` is
    /// empty.
    max_results: ?i32 = null,

    /// Set the maximum number of instances to print in the list.
    name_contains: ?[]const u8 = null,

    /// Set the next token to retrieve the list of SageMaker HyperPod clusters.
    next_token: ?[]const u8 = null,

    /// The field by which to sort results. The default value is `CREATION_TIME`.
    sort_by: ?ClusterSortBy = null,

    /// The sort order for results. The default value is `Ascending`.
    sort_order: ?SortOrder = null,

    /// The Amazon Resource Name (ARN); of the training plan to filter clusters by.
    /// For more information about reserving GPU capacity for your SageMaker
    /// HyperPod clusters using Amazon SageMaker Training Plan, see `
    /// [CreateTrainingPlan](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingPlan.html) `.
    training_plan_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .training_plan_arn = "TrainingPlanArn",
    };
};

pub const ListClustersOutput = struct {
    /// The summaries of listed SageMaker HyperPod clusters.
    cluster_summaries: ?[]const ClusterSummary = null,

    /// If the result of the previous `ListClusters` request was truncated, the
    /// response includes a `NextToken`. To retrieve the next set of clusters, use
    /// the token in the next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_summaries = "ClusterSummaries",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListClustersInput, options: Options) !ListClustersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListClustersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListClusters");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListClustersOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListClustersOutput, body, allocator);
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
