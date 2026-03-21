const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const InferenceExperimentDataStorageConfig = @import("inference_experiment_data_storage_config.zig").InferenceExperimentDataStorageConfig;
const ModelVariantConfig = @import("model_variant_config.zig").ModelVariantConfig;
const InferenceExperimentSchedule = @import("inference_experiment_schedule.zig").InferenceExperimentSchedule;
const ShadowModeConfig = @import("shadow_mode_config.zig").ShadowModeConfig;

pub const UpdateInferenceExperimentInput = struct {
    /// The Amazon S3 location and configuration for storing inference request and
    /// response data.
    data_storage_config: ?InferenceExperimentDataStorageConfig = null,

    /// The description of the inference experiment.
    description: ?[]const u8 = null,

    /// An array of `ModelVariantConfig` objects. There is one for each variant,
    /// whose infrastructure configuration you want to update.
    model_variants: ?[]const ModelVariantConfig = null,

    /// The name of the inference experiment to be updated.
    name: []const u8,

    /// The duration for which the inference experiment will run. If the status of
    /// the inference experiment is `Created`, then you can update both the start
    /// and end dates. If the status of the inference experiment is `Running`, then
    /// you can update only the end date.
    schedule: ?InferenceExperimentSchedule = null,

    /// The configuration of `ShadowMode` inference experiment type. Use this field
    /// to specify a production variant which takes all the inference requests, and
    /// a shadow variant to which Amazon SageMaker replicates a percentage of the
    /// inference requests. For the shadow variant also specify the percentage of
    /// requests that Amazon SageMaker replicates.
    shadow_mode_config: ?ShadowModeConfig = null,

    pub const json_field_names = .{
        .data_storage_config = "DataStorageConfig",
        .description = "Description",
        .model_variants = "ModelVariants",
        .name = "Name",
        .schedule = "Schedule",
        .shadow_mode_config = "ShadowModeConfig",
    };
};

pub const UpdateInferenceExperimentOutput = struct {
    /// The ARN of the updated inference experiment.
    inference_experiment_arn: []const u8,

    pub const json_field_names = .{
        .inference_experiment_arn = "InferenceExperimentArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateInferenceExperimentInput, options: CallOptions) !UpdateInferenceExperimentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateInferenceExperimentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateInferenceExperiment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateInferenceExperimentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateInferenceExperimentOutput, body, allocator);
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
