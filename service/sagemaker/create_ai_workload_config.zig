const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AIWorkloadConfigs = @import("ai_workload_configs.zig").AIWorkloadConfigs;
const AIDatasetConfig = @import("ai_dataset_config.zig").AIDatasetConfig;
const Tag = @import("tag.zig").Tag;

pub const CreateAIWorkloadConfigInput = struct {
    /// The name of the AI workload configuration. The name must be unique within
    /// your Amazon Web Services account in the current Amazon Web Services Region.
    ai_workload_config_name: []const u8,

    /// The benchmark tool configuration and workload specification. Provide the
    /// specification as an inline YAML or JSON string.
    ai_workload_configs: ?AIWorkloadConfigs = null,

    /// The dataset configuration for the workload. Specify input data channels with
    /// their data sources for benchmark workloads.
    dataset_config: ?AIDatasetConfig = null,

    /// The metadata that you apply to Amazon Web Services resources to help you
    /// categorize and organize them. Each tag consists of a key and a value, both
    /// of which you define. For more information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the Amazon Web Services General Reference.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .ai_workload_config_name = "AIWorkloadConfigName",
        .ai_workload_configs = "AIWorkloadConfigs",
        .dataset_config = "DatasetConfig",
        .tags = "Tags",
    };
};

pub const CreateAIWorkloadConfigOutput = struct {
    /// The Amazon Resource Name (ARN) of the created AI workload configuration.
    ai_workload_config_arn: []const u8,

    pub const json_field_names = .{
        .ai_workload_config_arn = "AIWorkloadConfigArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAIWorkloadConfigInput, options: CallOptions) !CreateAIWorkloadConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAIWorkloadConfigInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateAIWorkloadConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAIWorkloadConfigOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateAIWorkloadConfigOutput, body, allocator);
}
