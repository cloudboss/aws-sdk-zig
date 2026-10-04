const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTrainingJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateTrainingJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTrainingJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateTrainingJobOutput, body, allocator);
}
