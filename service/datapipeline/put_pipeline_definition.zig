const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const ParameterObject = @import("parameter_object.zig").ParameterObject;
const ParameterValue = @import("parameter_value.zig").ParameterValue;
const PipelineObject = @import("pipeline_object.zig").PipelineObject;
const ValidationError = @import("validation_error.zig").ValidationError;
const ValidationWarning = @import("validation_warning.zig").ValidationWarning;

pub const PutPipelineDefinitionInput = struct {
    /// The parameter objects used with the pipeline.
    parameter_objects: ?[]const ParameterObject = null,

    /// The parameter values used with the pipeline.
    parameter_values: ?[]const ParameterValue = null,

    /// The ID of the pipeline.
    pipeline_id: []const u8,

    /// The objects that define the pipeline. These objects overwrite the existing
    /// pipeline definition.
    pipeline_objects: []const PipelineObject,

    pub const json_field_names = .{
        .parameter_objects = "parameterObjects",
        .parameter_values = "parameterValues",
        .pipeline_id = "pipelineId",
        .pipeline_objects = "pipelineObjects",
    };
};

pub const PutPipelineDefinitionOutput = struct {
    /// Indicates whether there were validation errors, and the pipeline definition
    /// is stored but cannot be
    /// activated until you correct the pipeline and call `PutPipelineDefinition` to
    /// commit the corrected pipeline.
    errored: ?bool = null,

    /// The validation errors that are associated with the objects defined in
    /// `pipelineObjects`.
    validation_errors: ?[]const ValidationError = null,

    /// The validation warnings that are associated with the objects defined in
    /// `pipelineObjects`.
    validation_warnings: ?[]const ValidationWarning = null,

    pub const json_field_names = .{
        .errored = "errored",
        .validation_errors = "validationErrors",
        .validation_warnings = "validationWarnings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutPipelineDefinitionInput, options: CallOptions) !PutPipelineDefinitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutPipelineDefinitionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DataPipeline.PutPipelineDefinition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutPipelineDefinitionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(PutPipelineDefinitionOutput, body, allocator);
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
