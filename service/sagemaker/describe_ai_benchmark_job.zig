const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AIBenchmarkJobStatus = @import("ai_benchmark_job_status.zig").AIBenchmarkJobStatus;
const AIBenchmarkTarget = @import("ai_benchmark_target.zig").AIBenchmarkTarget;
const AIBenchmarkNetworkConfig = @import("ai_benchmark_network_config.zig").AIBenchmarkNetworkConfig;
const AIBenchmarkOutputResult = @import("ai_benchmark_output_result.zig").AIBenchmarkOutputResult;
const Tag = @import("tag.zig").Tag;

pub const DescribeAIBenchmarkJobInput = struct {
    /// The name of the AI benchmark job to describe.
    ai_benchmark_job_name: []const u8,

    pub const json_field_names = .{
        .ai_benchmark_job_name = "AIBenchmarkJobName",
    };
};

pub const DescribeAIBenchmarkJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the AI benchmark job.
    ai_benchmark_job_arn: []const u8,

    /// The name of the AI benchmark job.
    ai_benchmark_job_name: []const u8,

    /// The status of the AI benchmark job.
    ai_benchmark_job_status: AIBenchmarkJobStatus,

    /// The name or Amazon Resource Name (ARN) of the AI workload configuration used
    /// for this benchmark job.
    ai_workload_config_identifier: []const u8,

    /// The target endpoint that was benchmarked.
    benchmark_target: ?AIBenchmarkTarget = null,

    /// A timestamp that indicates when the benchmark job was created.
    creation_time: i64,

    /// A timestamp that indicates when the benchmark job completed.
    end_time: ?i64 = null,

    /// If the benchmark job failed, the reason it failed.
    failure_reason: ?[]const u8 = null,

    /// The network configuration for the benchmark job.
    network_config: ?AIBenchmarkNetworkConfig = null,

    /// The output configuration for the benchmark job, including the Amazon S3
    /// output location and CloudWatch log information.
    output_config: ?AIBenchmarkOutputResult = null,

    /// The Amazon Resource Name (ARN) of the IAM role used by the benchmark job.
    role_arn: []const u8,

    /// A timestamp that indicates when the benchmark job started running.
    start_time: ?i64 = null,

    /// The tags associated with the benchmark job.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .ai_benchmark_job_arn = "AIBenchmarkJobArn",
        .ai_benchmark_job_name = "AIBenchmarkJobName",
        .ai_benchmark_job_status = "AIBenchmarkJobStatus",
        .ai_workload_config_identifier = "AIWorkloadConfigIdentifier",
        .benchmark_target = "BenchmarkTarget",
        .creation_time = "CreationTime",
        .end_time = "EndTime",
        .failure_reason = "FailureReason",
        .network_config = "NetworkConfig",
        .output_config = "OutputConfig",
        .role_arn = "RoleArn",
        .start_time = "StartTime",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAIBenchmarkJobInput, options: CallOptions) !DescribeAIBenchmarkJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAIBenchmarkJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeAIBenchmarkJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAIBenchmarkJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeAIBenchmarkJobOutput, body, allocator);
}
