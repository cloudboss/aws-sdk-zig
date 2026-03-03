const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SortInferenceExperimentsBy = @import("sort_inference_experiments_by.zig").SortInferenceExperimentsBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const InferenceExperimentStatus = @import("inference_experiment_status.zig").InferenceExperimentStatus;
const InferenceExperimentType = @import("inference_experiment_type.zig").InferenceExperimentType;
const InferenceExperimentSummary = @import("inference_experiment_summary.zig").InferenceExperimentSummary;

pub const ListInferenceExperimentsInput = struct {
    /// Selects inference experiments which were created after this timestamp.
    creation_time_after: ?i64 = null,

    /// Selects inference experiments which were created before this timestamp.
    creation_time_before: ?i64 = null,

    /// Selects inference experiments which were last modified after this timestamp.
    last_modified_time_after: ?i64 = null,

    /// Selects inference experiments which were last modified before this
    /// timestamp.
    last_modified_time_before: ?i64 = null,

    /// The maximum number of results to select.
    max_results: ?i32 = null,

    /// Selects inference experiments whose names contain this name.
    name_contains: ?[]const u8 = null,

    /// The response from the last list when returning a list large enough to need
    /// tokening.
    next_token: ?[]const u8 = null,

    /// The column by which to sort the listed inference experiments.
    sort_by: ?SortInferenceExperimentsBy = null,

    /// The direction of sorting (ascending or descending).
    sort_order: ?SortOrder = null,

    /// Selects inference experiments which are in this status. For the possible
    /// statuses, see
    /// [DescribeInferenceExperiment](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeInferenceExperiment.html).
    status_equals: ?InferenceExperimentStatus = null,

    /// Selects inference experiments of this type. For the possible types of
    /// inference experiments, see
    /// [CreateInferenceExperiment](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateInferenceExperiment.html).
    @"type": ?InferenceExperimentType = null,

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
        .status_equals = "StatusEquals",
        .@"type" = "Type",
    };
};

pub const ListInferenceExperimentsOutput = struct {
    /// List of inference experiments.
    inference_experiments: ?[]const InferenceExperimentSummary = null,

    /// The token to use when calling the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .inference_experiments = "InferenceExperiments",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInferenceExperimentsInput, options: Options) !ListInferenceExperimentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInferenceExperimentsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListInferenceExperiments");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInferenceExperimentsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListInferenceExperimentsOutput, body, allocator);
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
