const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Autotune = @import("autotune.zig").Autotune;
const HyperParameterTrainingJobSummary = @import("hyper_parameter_training_job_summary.zig").HyperParameterTrainingJobSummary;
const HyperParameterTuningJobConsumedResources = @import("hyper_parameter_tuning_job_consumed_resources.zig").HyperParameterTuningJobConsumedResources;
const HyperParameterTuningJobConfig = @import("hyper_parameter_tuning_job_config.zig").HyperParameterTuningJobConfig;
const HyperParameterTuningJobStatus = @import("hyper_parameter_tuning_job_status.zig").HyperParameterTuningJobStatus;
const ObjectiveStatusCounters = @import("objective_status_counters.zig").ObjectiveStatusCounters;
const HyperParameterTrainingJobDefinition = @import("hyper_parameter_training_job_definition.zig").HyperParameterTrainingJobDefinition;
const TrainingJobStatusCounters = @import("training_job_status_counters.zig").TrainingJobStatusCounters;
const HyperParameterTuningJobCompletionDetails = @import("hyper_parameter_tuning_job_completion_details.zig").HyperParameterTuningJobCompletionDetails;
const HyperParameterTuningJobWarmStartConfig = @import("hyper_parameter_tuning_job_warm_start_config.zig").HyperParameterTuningJobWarmStartConfig;

pub const DescribeHyperParameterTuningJobInput = struct {
    /// The name of the tuning job.
    hyper_parameter_tuning_job_name: []const u8,

    pub const json_field_names = .{
        .hyper_parameter_tuning_job_name = "HyperParameterTuningJobName",
    };
};

pub const DescribeHyperParameterTuningJobOutput = struct {
    /// A flag to indicate if autotune is enabled for the hyperparameter tuning job.
    autotune: ?Autotune = null,

    /// A
    /// [TrainingJobSummary](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_TrainingJobSummary.html) object that describes the training job that completed with the best current [HyperParameterTuningJobObjective](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterTuningJobObjective.html).
    best_training_job: ?HyperParameterTrainingJobSummary = null,

    consumed_resources: ?HyperParameterTuningJobConsumedResources = null,

    /// The date and time that the tuning job started.
    creation_time: i64,

    /// If the tuning job failed, the reason it failed.
    failure_reason: ?[]const u8 = null,

    /// The date and time that the tuning job ended.
    hyper_parameter_tuning_end_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the tuning job.
    hyper_parameter_tuning_job_arn: []const u8,

    /// The
    /// [HyperParameterTuningJobConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterTuningJobConfig.html) object that specifies the configuration of the tuning job.
    hyper_parameter_tuning_job_config: ?HyperParameterTuningJobConfig = null,

    /// The name of the hyperparameter tuning job.
    hyper_parameter_tuning_job_name: []const u8,

    /// The status of the tuning job.
    hyper_parameter_tuning_job_status: HyperParameterTuningJobStatus,

    /// The date and time that the status of the tuning job was modified.
    last_modified_time: ?i64 = null,

    /// The
    /// [ObjectiveStatusCounters](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ObjectiveStatusCounters.html) object that specifies the number of training jobs, categorized by the status of their final objective metric, that this tuning job launched.
    objective_status_counters: ?ObjectiveStatusCounters = null,

    /// If the hyperparameter tuning job is an warm start tuning job with a
    /// `WarmStartType` of `IDENTICAL_DATA_AND_ALGORITHM`, this is the
    /// [TrainingJobSummary](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_TrainingJobSummary.html) for the training job with the best objective metric value of all training jobs launched by this tuning job and all parent jobs specified for the warm start tuning job.
    overall_best_training_job: ?HyperParameterTrainingJobSummary = null,

    /// The
    /// [HyperParameterTrainingJobDefinition](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterTrainingJobDefinition.html) object that specifies the definition of the training jobs that this tuning job launches.
    training_job_definition: ?HyperParameterTrainingJobDefinition = null,

    /// A list of the
    /// [HyperParameterTrainingJobDefinition](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterTrainingJobDefinition.html) objects launched for this tuning job.
    training_job_definitions: ?[]const HyperParameterTrainingJobDefinition = null,

    /// The
    /// [TrainingJobStatusCounters](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_TrainingJobStatusCounters.html) object that specifies the number of training jobs, categorized by status, that this tuning job launched.
    training_job_status_counters: ?TrainingJobStatusCounters = null,

    /// Tuning job completion information returned as the response from a
    /// hyperparameter tuning job. This information tells if your tuning job has or
    /// has not converged. It also includes the number of training jobs that have
    /// not improved model performance as evaluated against the objective function.
    tuning_job_completion_details: ?HyperParameterTuningJobCompletionDetails = null,

    /// The configuration for starting the hyperparameter parameter tuning job using
    /// one or more previous tuning jobs as a starting point. The results of
    /// previous tuning jobs are used to inform which combinations of
    /// hyperparameters to search over in the new tuning job.
    warm_start_config: ?HyperParameterTuningJobWarmStartConfig = null,

    pub const json_field_names = .{
        .autotune = "Autotune",
        .best_training_job = "BestTrainingJob",
        .consumed_resources = "ConsumedResources",
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .hyper_parameter_tuning_end_time = "HyperParameterTuningEndTime",
        .hyper_parameter_tuning_job_arn = "HyperParameterTuningJobArn",
        .hyper_parameter_tuning_job_config = "HyperParameterTuningJobConfig",
        .hyper_parameter_tuning_job_name = "HyperParameterTuningJobName",
        .hyper_parameter_tuning_job_status = "HyperParameterTuningJobStatus",
        .last_modified_time = "LastModifiedTime",
        .objective_status_counters = "ObjectiveStatusCounters",
        .overall_best_training_job = "OverallBestTrainingJob",
        .training_job_definition = "TrainingJobDefinition",
        .training_job_definitions = "TrainingJobDefinitions",
        .training_job_status_counters = "TrainingJobStatusCounters",
        .tuning_job_completion_details = "TuningJobCompletionDetails",
        .warm_start_config = "WarmStartConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeHyperParameterTuningJobInput, options: CallOptions) !DescribeHyperParameterTuningJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeHyperParameterTuningJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeHyperParameterTuningJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeHyperParameterTuningJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeHyperParameterTuningJobOutput, body, allocator);
}
