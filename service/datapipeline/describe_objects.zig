const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const PipelineObject = @import("pipeline_object.zig").PipelineObject;

pub const DescribeObjectsInput = struct {
    /// Indicates whether any expressions in the object should be evaluated when the
    /// object descriptions are returned.
    evaluate_expressions: ?bool = null,

    /// The starting point for the results to be returned. For the first call, this
    /// value should be empty.
    /// As long as there are more results, continue to call `DescribeObjects` with
    /// the marker value from the previous call to retrieve the next set of results.
    marker: ?[]const u8 = null,

    /// The IDs of the pipeline objects that contain the definitions to be
    /// described. You can pass as many as 25 identifiers in a single call to
    /// `DescribeObjects`.
    object_ids: []const []const u8,

    /// The ID of the pipeline that contains the object definitions.
    pipeline_id: []const u8,

    pub const json_field_names = .{
        .evaluate_expressions = "evaluateExpressions",
        .marker = "marker",
        .object_ids = "objectIds",
        .pipeline_id = "pipelineId",
    };
};

pub const DescribeObjectsOutput = struct {
    /// Indicates whether there are more results to return.
    has_more_results: ?bool = null,

    /// The starting point for the next page of results. To view the next page of
    /// results, call `DescribeObjects`
    /// again with this marker value. If the value is null, there are no more
    /// results.
    marker: ?[]const u8 = null,

    /// An array of object definitions.
    pipeline_objects: ?[]const PipelineObject = null,

    pub const json_field_names = .{
        .has_more_results = "hasMoreResults",
        .marker = "marker",
        .pipeline_objects = "pipelineObjects",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeObjectsInput, options: CallOptions) !DescribeObjectsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datapipeline", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeObjectsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datapipeline", "Data Pipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DataPipeline.DescribeObjects");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeObjectsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeObjectsOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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

    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        const parsed_error: ?errors.InternalServiceError = aws.json.parseJsonObject(errors.InternalServiceError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_service_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        const parsed_error: ?errors.InvalidRequestException = aws.json.parseJsonObject(errors.InvalidRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PipelineDeletedException")) {
        const parsed_error: ?errors.PipelineDeletedException = aws.json.parseJsonObject(errors.PipelineDeletedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .pipeline_deleted_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PipelineNotFoundException")) {
        const parsed_error: ?errors.PipelineNotFoundException = aws.json.parseJsonObject(errors.PipelineNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .pipeline_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TaskNotFoundException")) {
        const parsed_error: ?errors.TaskNotFoundException = aws.json.parseJsonObject(errors.TaskNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .task_not_found_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
