const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoMLJobConfig = @import("auto_ml_job_config.zig").AutoMLJobConfig;
const AutoMLJobObjective = @import("auto_ml_job_objective.zig").AutoMLJobObjective;
const AutoMLChannel = @import("auto_ml_channel.zig").AutoMLChannel;
const ModelDeployConfig = @import("model_deploy_config.zig").ModelDeployConfig;
const AutoMLOutputDataConfig = @import("auto_ml_output_data_config.zig").AutoMLOutputDataConfig;
const ProblemType = @import("problem_type.zig").ProblemType;
const Tag = @import("tag.zig").Tag;

pub const CreateAutoMLJobInput = struct {
    /// A collection of settings used to configure an AutoML job.
    auto_ml_job_config: ?AutoMLJobConfig = null,

    /// Identifies an Autopilot job. The name must be unique to your account and is
    /// case insensitive.
    auto_ml_job_name: []const u8,

    /// Specifies a metric to minimize or maximize as the objective of a job. If not
    /// specified, the default objective metric depends on the problem type. See
    /// [AutoMLJobObjective](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_AutoMLJobObjective.html) for the default values.
    auto_ml_job_objective: ?AutoMLJobObjective = null,

    /// Generates possible candidates without training the models. A candidate is a
    /// combination of data preprocessors, algorithms, and algorithm parameter
    /// settings.
    generate_candidate_definitions_only: ?bool = null,

    /// An array of channel objects that describes the input data and its location.
    /// Each channel is a named input source. Similar to `InputDataConfig` supported
    /// by
    /// [HyperParameterTrainingJobDefinition](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterTrainingJobDefinition.html). Format(s) supported: CSV, Parquet. A minimum of 500 rows is required for the training dataset. There is not a minimum number of rows required for the validation dataset.
    input_data_config: []const AutoMLChannel,

    /// Specifies how to generate the endpoint name for an automatic one-click
    /// Autopilot model deployment.
    model_deploy_config: ?ModelDeployConfig = null,

    /// Provides information about encryption and the Amazon S3 output path needed
    /// to store artifacts from an AutoML job. Format(s) supported: CSV.
    output_data_config: AutoMLOutputDataConfig,

    /// Defines the type of supervised learning problem available for the
    /// candidates. For more information, see [ SageMaker Autopilot problem
    /// types](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-datasets-problem-types.html#autopilot-problem-types).
    problem_type: ?ProblemType = null,

    /// The ARN of the role that is used to access the data.
    role_arn: []const u8,

    /// An array of key-value pairs. You can use tags to categorize your Amazon Web
    /// Services resources in different ways, for example, by purpose, owner, or
    /// environment. For more information, see [Tagging Amazon Web
    /// ServicesResources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html). Tag keys must be unique per resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .auto_ml_job_config = "AutoMLJobConfig",
        .auto_ml_job_name = "AutoMLJobName",
        .auto_ml_job_objective = "AutoMLJobObjective",
        .generate_candidate_definitions_only = "GenerateCandidateDefinitionsOnly",
        .input_data_config = "InputDataConfig",
        .model_deploy_config = "ModelDeployConfig",
        .output_data_config = "OutputDataConfig",
        .problem_type = "ProblemType",
        .role_arn = "RoleArn",
        .tags = "Tags",
    };
};

pub const CreateAutoMLJobOutput = struct {
    /// The unique ARN assigned to the AutoML job when it is created.
    auto_ml_job_arn: []const u8,

    pub const json_field_names = .{
        .auto_ml_job_arn = "AutoMLJobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAutoMLJobInput, options: CallOptions) !CreateAutoMLJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAutoMLJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateAutoMLJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAutoMLJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateAutoMLJobOutput, body, allocator);
}
