const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoMLJobArtifacts = @import("auto_ml_job_artifacts.zig").AutoMLJobArtifacts;
const AutoMLJobConfig = @import("auto_ml_job_config.zig").AutoMLJobConfig;
const AutoMLJobObjective = @import("auto_ml_job_objective.zig").AutoMLJobObjective;
const AutoMLJobSecondaryStatus = @import("auto_ml_job_secondary_status.zig").AutoMLJobSecondaryStatus;
const AutoMLJobStatus = @import("auto_ml_job_status.zig").AutoMLJobStatus;
const AutoMLCandidate = @import("auto_ml_candidate.zig").AutoMLCandidate;
const AutoMLChannel = @import("auto_ml_channel.zig").AutoMLChannel;
const ModelDeployConfig = @import("model_deploy_config.zig").ModelDeployConfig;
const ModelDeployResult = @import("model_deploy_result.zig").ModelDeployResult;
const AutoMLOutputDataConfig = @import("auto_ml_output_data_config.zig").AutoMLOutputDataConfig;
const AutoMLPartialFailureReason = @import("auto_ml_partial_failure_reason.zig").AutoMLPartialFailureReason;
const ProblemType = @import("problem_type.zig").ProblemType;
const ResolvedAttributes = @import("resolved_attributes.zig").ResolvedAttributes;

pub const DescribeAutoMLJobInput = struct {
    /// Requests information about an AutoML job using its unique name.
    auto_ml_job_name: []const u8,

    pub const json_field_names = .{
        .auto_ml_job_name = "AutoMLJobName",
    };
};

pub const DescribeAutoMLJobOutput = struct {
    /// Returns the ARN of the AutoML job.
    auto_ml_job_arn: []const u8,

    /// Returns information on the job's artifacts found in `AutoMLJobArtifacts`.
    auto_ml_job_artifacts: ?AutoMLJobArtifacts = null,

    /// Returns the configuration for the AutoML job.
    auto_ml_job_config: ?AutoMLJobConfig = null,

    /// Returns the name of the AutoML job.
    auto_ml_job_name: []const u8,

    /// Returns the job's objective.
    auto_ml_job_objective: ?AutoMLJobObjective = null,

    /// Returns the secondary status of the AutoML job.
    auto_ml_job_secondary_status: AutoMLJobSecondaryStatus,

    /// Returns the status of the AutoML job.
    auto_ml_job_status: AutoMLJobStatus,

    /// The best model candidate selected by SageMaker AI Autopilot using both the
    /// best objective metric and lowest
    /// [InferenceLatency](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-metrics-validation.html) for an experiment.
    best_candidate: ?AutoMLCandidate = null,

    /// Returns the creation time of the AutoML job.
    creation_time: i64,

    /// Returns the end time of the AutoML job.
    end_time: ?i64 = null,

    /// Returns the failure reason for an AutoML job, when applicable.
    failure_reason: ?[]const u8 = null,

    /// Indicates whether the output for an AutoML job generates candidate
    /// definitions only.
    generate_candidate_definitions_only: ?bool = null,

    /// Returns the input data configuration for the AutoML job.
    input_data_config: ?[]const AutoMLChannel = null,

    /// Returns the job's last modified time.
    last_modified_time: i64,

    /// Indicates whether the model was deployed automatically to an endpoint and
    /// the name of that endpoint if deployed automatically.
    model_deploy_config: ?ModelDeployConfig = null,

    /// Provides information about endpoint for the model deployment.
    model_deploy_result: ?ModelDeployResult = null,

    /// Returns the job's output data config.
    output_data_config: ?AutoMLOutputDataConfig = null,

    /// Returns a list of reasons for partial failures within an AutoML job.
    partial_failure_reasons: ?[]const AutoMLPartialFailureReason = null,

    /// Returns the job's problem type.
    problem_type: ?ProblemType = null,

    /// Contains `ProblemType`, `AutoMLJobObjective`, and `CompletionCriteria`. If
    /// you do not provide these values, they are inferred.
    resolved_attributes: ?ResolvedAttributes = null,

    /// The ARN of the IAM role that has read permission to the input data location
    /// and write permission to the output data location in Amazon S3.
    role_arn: []const u8,

    pub const json_field_names = .{
        .auto_ml_job_arn = "AutoMLJobArn",
        .auto_ml_job_artifacts = "AutoMLJobArtifacts",
        .auto_ml_job_config = "AutoMLJobConfig",
        .auto_ml_job_name = "AutoMLJobName",
        .auto_ml_job_objective = "AutoMLJobObjective",
        .auto_ml_job_secondary_status = "AutoMLJobSecondaryStatus",
        .auto_ml_job_status = "AutoMLJobStatus",
        .best_candidate = "BestCandidate",
        .creation_time = "CreationTime",
        .end_time = "EndTime",
        .failure_reason = "FailureReason",
        .generate_candidate_definitions_only = "GenerateCandidateDefinitionsOnly",
        .input_data_config = "InputDataConfig",
        .last_modified_time = "LastModifiedTime",
        .model_deploy_config = "ModelDeployConfig",
        .model_deploy_result = "ModelDeployResult",
        .output_data_config = "OutputDataConfig",
        .partial_failure_reasons = "PartialFailureReasons",
        .problem_type = "ProblemType",
        .resolved_attributes = "ResolvedAttributes",
        .role_arn = "RoleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAutoMLJobInput, options: CallOptions) !DescribeAutoMLJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAutoMLJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeAutoMLJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAutoMLJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeAutoMLJobOutput, body, allocator);
}
