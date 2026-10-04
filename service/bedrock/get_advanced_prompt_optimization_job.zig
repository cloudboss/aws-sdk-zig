const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdvancedPromptOptimizationInputConfig = @import("advanced_prompt_optimization_input_config.zig").AdvancedPromptOptimizationInputConfig;
const AdvancedPromptOptimizationJobStatus = @import("advanced_prompt_optimization_job_status.zig").AdvancedPromptOptimizationJobStatus;
const ModelConfiguration = @import("model_configuration.zig").ModelConfiguration;
const AdvancedPromptOptimizationOutputConfig = @import("advanced_prompt_optimization_output_config.zig").AdvancedPromptOptimizationOutputConfig;

pub const GetAdvancedPromptOptimizationJobInput = struct {
    /// The ARN or ID of the advanced prompt optimization job.
    job_identifier: []const u8,

    pub const json_field_names = .{
        .job_identifier = "jobIdentifier",
    };
};

pub const GetAdvancedPromptOptimizationJobOutput = struct {
    /// The time at which the advanced prompt optimization job was created.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the output
    /// data.
    encryption_key_arn: ?[]const u8 = null,

    /// If the job failed, a message describing the reason for the failure.
    failure_message: ?[]const u8 = null,

    /// The input data configuration for the optimization job.
    input_config: ?AdvancedPromptOptimizationInputConfig = null,

    /// The Amazon Resource Name (ARN) of the advanced prompt optimization job.
    job_arn: []const u8,

    /// The description of the advanced prompt optimization job.
    job_description: ?[]const u8 = null,

    /// The name of the advanced prompt optimization job.
    job_name: []const u8,

    /// The status of the advanced prompt optimization job.
    job_status: AdvancedPromptOptimizationJobStatus,

    /// The time at which the advanced prompt optimization job was last modified.
    last_modified_time: ?i64 = null,

    /// The model configurations used in the optimization job.
    model_configurations: ?[]const ModelConfiguration = null,

    /// The output data configuration for the optimization job.
    output_config: ?AdvancedPromptOptimizationOutputConfig = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .encryption_key_arn = "encryptionKeyArn",
        .failure_message = "failureMessage",
        .input_config = "inputConfig",
        .job_arn = "jobArn",
        .job_description = "jobDescription",
        .job_name = "jobName",
        .job_status = "jobStatus",
        .last_modified_time = "lastModifiedTime",
        .model_configurations = "modelConfigurations",
        .output_config = "outputConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAdvancedPromptOptimizationJobInput, options: CallOptions) !GetAdvancedPromptOptimizationJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAdvancedPromptOptimizationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/advanced-prompt-optimization-jobs/");
    try path_buf.appendSlice(allocator, input.job_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAdvancedPromptOptimizationJobOutput {
    const result: GetAdvancedPromptOptimizationJobOutput = try aws.json.parseJsonObject(
        GetAdvancedPromptOptimizationJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
