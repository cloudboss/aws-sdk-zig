const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommendationJobInputConfig = @import("recommendation_job_input_config.zig").RecommendationJobInputConfig;
const RecommendationJobType = @import("recommendation_job_type.zig").RecommendationJobType;
const RecommendationJobOutputConfig = @import("recommendation_job_output_config.zig").RecommendationJobOutputConfig;
const RecommendationJobStoppingConditions = @import("recommendation_job_stopping_conditions.zig").RecommendationJobStoppingConditions;
const Tag = @import("tag.zig").Tag;

pub const CreateInferenceRecommendationsJobInput = struct {
    /// Provides information about the versioned model package Amazon Resource Name
    /// (ARN), the traffic pattern, and endpoint configurations.
    input_config: RecommendationJobInputConfig,

    /// Description of the recommendation job.
    job_description: ?[]const u8 = null,

    /// A name for the recommendation job. The name must be unique within the Amazon
    /// Web Services Region and within your Amazon Web Services account. The job
    /// name is passed down to the resources created by the recommendation job. The
    /// names of resources (such as the model, endpoint configuration, endpoint, and
    /// compilation) that are prefixed with the job name are truncated at 40
    /// characters.
    job_name: []const u8,

    /// Defines the type of recommendation job. Specify `Default` to initiate an
    /// instance recommendation and `Advanced` to initiate a load test. If left
    /// unspecified, Amazon SageMaker Inference Recommender will run an instance
    /// recommendation (`DEFAULT`) job.
    job_type: RecommendationJobType,

    /// Provides information about the output artifacts and the KMS key to use for
    /// Amazon S3 server-side encryption.
    output_config: ?RecommendationJobOutputConfig = null,

    /// The Amazon Resource Name (ARN) of an IAM role that enables Amazon SageMaker
    /// to perform tasks on your behalf.
    role_arn: []const u8,

    /// A set of conditions for stopping a recommendation job. If any of the
    /// conditions are met, the job is automatically stopped.
    stopping_conditions: ?RecommendationJobStoppingConditions = null,

    /// The metadata that you apply to Amazon Web Services resources to help you
    /// categorize and organize them. Each tag consists of a key and a value, both
    /// of which you define. For more information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the Amazon Web Services General Reference.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .input_config = "InputConfig",
        .job_description = "JobDescription",
        .job_name = "JobName",
        .job_type = "JobType",
        .output_config = "OutputConfig",
        .role_arn = "RoleArn",
        .stopping_conditions = "StoppingConditions",
        .tags = "Tags",
    };
};

pub const CreateInferenceRecommendationsJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the recommendation job.
    job_arn: []const u8,

    pub const json_field_names = .{
        .job_arn = "JobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInferenceRecommendationsJobInput, options: CallOptions) !CreateInferenceRecommendationsJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateInferenceRecommendationsJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateInferenceRecommendationsJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateInferenceRecommendationsJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateInferenceRecommendationsJobOutput, body, allocator);
}
