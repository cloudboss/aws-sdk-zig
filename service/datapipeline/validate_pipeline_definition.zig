const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ParameterObject = @import("parameter_object.zig").ParameterObject;
const ParameterValue = @import("parameter_value.zig").ParameterValue;
const PipelineObject = @import("pipeline_object.zig").PipelineObject;
const ValidationError = @import("validation_error.zig").ValidationError;
const ValidationWarning = @import("validation_warning.zig").ValidationWarning;

pub const ValidatePipelineDefinitionInput = struct {
    /// The parameter objects used with the pipeline.
    parameter_objects: ?[]const ParameterObject = null,

    /// The parameter values used with the pipeline.
    parameter_values: ?[]const ParameterValue = null,

    /// The ID of the pipeline.
    pipeline_id: []const u8,

    /// The objects that define the pipeline changes to validate against the
    /// pipeline.
    pipeline_objects: []const PipelineObject,

    pub const json_field_names = .{
        .parameter_objects = "parameterObjects",
        .parameter_values = "parameterValues",
        .pipeline_id = "pipelineId",
        .pipeline_objects = "pipelineObjects",
    };
};

pub const ValidatePipelineDefinitionOutput = struct {
    /// Indicates whether there were validation errors.
    errored: ?bool = null,

    /// Any validation errors that were found.
    validation_errors: ?[]const ValidationError = null,

    /// Any validation warnings that were found.
    validation_warnings: ?[]const ValidationWarning = null,

    pub const json_field_names = .{
        .errored = "errored",
        .validation_errors = "validationErrors",
        .validation_warnings = "validationWarnings",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ValidatePipelineDefinitionInput, options: Options) !ValidatePipelineDefinitionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datapipeline");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ValidatePipelineDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datapipeline", "Data Pipeline", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "DataPipeline.ValidatePipelineDefinition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ValidatePipelineDefinitionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ValidatePipelineDefinitionOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PipelineDeletedException")) {
        return .{ .arena = arena, .kind = .{ .pipeline_deleted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PipelineNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .pipeline_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TaskNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .task_not_found_exception = .{
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
