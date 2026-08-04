const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const InferenceComponentStatus = @import("inference_component_status.zig").InferenceComponentStatus;
const InferenceComponentDeploymentConfig = @import("inference_component_deployment_config.zig").InferenceComponentDeploymentConfig;
const InferenceComponentRuntimeConfigSummary = @import("inference_component_runtime_config_summary.zig").InferenceComponentRuntimeConfigSummary;
const InferenceComponentSpecificationSummary = @import("inference_component_specification_summary.zig").InferenceComponentSpecificationSummary;

pub const DescribeInferenceComponentInput = struct {
    /// The name of the inference component.
    inference_component_name: []const u8,

    pub const json_field_names = .{
        .inference_component_name = "InferenceComponentName",
    };
};

pub const DescribeInferenceComponentOutput = struct {
    /// The time when the inference component was created.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the endpoint that hosts the inference
    /// component.
    endpoint_arn: []const u8,

    /// The name of the endpoint that hosts the inference component.
    endpoint_name: []const u8,

    /// If the inference component status is `Failed`, the reason for the failure.
    failure_reason: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the inference component.
    inference_component_arn: []const u8,

    /// The name of the inference component.
    inference_component_name: []const u8,

    /// The status of the inference component.
    inference_component_status: ?InferenceComponentStatus = null,

    /// The deployment and rollback settings that you assigned to the inference
    /// component.
    last_deployment_config: ?InferenceComponentDeploymentConfig = null,

    /// The time when the inference component was last updated.
    last_modified_time: i64,

    /// Details about the runtime settings for the model that is deployed with the
    /// inference component.
    runtime_config: ?InferenceComponentRuntimeConfigSummary = null,

    /// Details about the resources that are deployed with this inference component.
    specification: ?InferenceComponentSpecificationSummary = null,

    /// A list of specification summaries for the inference component, one per
    /// instance type. This parameter is populated when the inference component was
    /// created with multiple specifications. When this parameter is populated, the
    /// singular `Specification` parameter is not returned.
    specifications: ?[]const InferenceComponentSpecificationSummary = null,

    /// The name of the production variant that hosts the inference component.
    variant_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .endpoint_arn = "EndpointArn",
        .endpoint_name = "EndpointName",
        .failure_reason = "FailureReason",
        .inference_component_arn = "InferenceComponentArn",
        .inference_component_name = "InferenceComponentName",
        .inference_component_status = "InferenceComponentStatus",
        .last_deployment_config = "LastDeploymentConfig",
        .last_modified_time = "LastModifiedTime",
        .runtime_config = "RuntimeConfig",
        .specification = "Specification",
        .specifications = "Specifications",
        .variant_name = "VariantName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInferenceComponentInput, options: CallOptions) !DescribeInferenceComponentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInferenceComponentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeInferenceComponent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInferenceComponentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeInferenceComponentOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        const parsed_error: ?errors.ResourceInUse = aws.json.parseJsonObject(errors.ResourceInUse, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_in_use = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        const parsed_error: ?errors.ResourceLimitExceeded = aws.json.parseJsonObject(errors.ResourceLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        const parsed_error: ?errors.ResourceNotFound = aws.json.parseJsonObject(errors.ResourceNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found = typed_error } };
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
