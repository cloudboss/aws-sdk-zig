const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ProfilerConfigForUpdate = @import("profiler_config_for_update.zig").ProfilerConfigForUpdate;
const ProfilerRuleConfiguration = @import("profiler_rule_configuration.zig").ProfilerRuleConfiguration;
const RemoteDebugConfigForUpdate = @import("remote_debug_config_for_update.zig").RemoteDebugConfigForUpdate;
const ResourceConfigForUpdate = @import("resource_config_for_update.zig").ResourceConfigForUpdate;

pub const UpdateTrainingJobInput = struct {
    /// Configuration information for Amazon SageMaker Debugger system monitoring,
    /// framework profiling, and storage paths.
    profiler_config: ?ProfilerConfigForUpdate = null,

    /// Configuration information for Amazon SageMaker Debugger rules for profiling
    /// system and framework metrics.
    profiler_rule_configurations: ?[]const ProfilerRuleConfiguration = null,

    /// Configuration for remote debugging while the training job is running. You
    /// can update the remote debugging configuration when the `SecondaryStatus` of
    /// the job is `Downloading` or `Training`.To learn more about the remote
    /// debugging functionality of SageMaker, see [Access a training container
    /// through Amazon Web Services Systems Manager (SSM) for remote
    /// debugging](https://docs.aws.amazon.com/sagemaker/latest/dg/train-remote-debugging.html).
    remote_debug_config: ?RemoteDebugConfigForUpdate = null,

    /// The training job `ResourceConfig` to update warm pool retention length.
    resource_config: ?ResourceConfigForUpdate = null,

    /// The name of a training job to update the Debugger profiling configuration.
    training_job_name: []const u8,

    pub const json_field_names = .{
        .profiler_config = "ProfilerConfig",
        .profiler_rule_configurations = "ProfilerRuleConfigurations",
        .remote_debug_config = "RemoteDebugConfig",
        .resource_config = "ResourceConfig",
        .training_job_name = "TrainingJobName",
    };
};

pub const UpdateTrainingJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the training job.
    training_job_arn: []const u8,

    pub const json_field_names = .{
        .training_job_arn = "TrainingJobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTrainingJobInput, options: CallOptions) !UpdateTrainingJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTrainingJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateTrainingJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTrainingJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateTrainingJobOutput, body, allocator);
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
