const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InferenceSpecification = @import("inference_specification.zig").InferenceSpecification;
const Tag = @import("tag.zig").Tag;
const TrainingSpecification = @import("training_specification.zig").TrainingSpecification;
const AlgorithmValidationSpecification = @import("algorithm_validation_specification.zig").AlgorithmValidationSpecification;

pub const CreateAlgorithmInput = struct {
    /// A description of the algorithm.
    algorithm_description: ?[]const u8 = null,

    /// The name of the algorithm.
    algorithm_name: []const u8,

    /// Whether to certify the algorithm so that it can be listed in Amazon Web
    /// Services Marketplace.
    certify_for_marketplace: ?bool = null,

    /// Specifies details about inference jobs that the algorithm runs, including
    /// the following:
    ///
    /// * The Amazon ECR paths of containers that contain the inference code and
    ///   model artifacts.
    /// * The instance types that the algorithm supports for transform jobs and
    ///   real-time endpoints used for inference.
    /// * The input and output content formats that the algorithm supports for
    ///   inference.
    inference_specification: ?InferenceSpecification = null,

    /// An array of key-value pairs. You can use tags to categorize your Amazon Web
    /// Services resources in different ways, for example, by purpose, owner, or
    /// environment. For more information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    tags: ?[]const Tag = null,

    /// Specifies details about training jobs run by this algorithm, including the
    /// following:
    ///
    /// * The Amazon ECR path of the container and the version digest of the
    ///   algorithm.
    /// * The hyperparameters that the algorithm supports.
    /// * The instance types that the algorithm supports for training.
    /// * Whether the algorithm supports distributed training.
    /// * The metrics that the algorithm emits to Amazon CloudWatch.
    /// * Which metrics that the algorithm emits can be used as the objective metric
    ///   for hyperparameter tuning jobs.
    /// * The input channels that the algorithm supports for training data. For
    ///   example, an algorithm might support `train`, `validation`, and `test`
    ///   channels.
    training_specification: TrainingSpecification,

    /// Specifies configurations for one or more training jobs and that SageMaker
    /// runs to test the algorithm's training code and, optionally, one or more
    /// batch transform jobs that SageMaker runs to test the algorithm's inference
    /// code.
    validation_specification: ?AlgorithmValidationSpecification = null,

    pub const json_field_names = .{
        .algorithm_description = "AlgorithmDescription",
        .algorithm_name = "AlgorithmName",
        .certify_for_marketplace = "CertifyForMarketplace",
        .inference_specification = "InferenceSpecification",
        .tags = "Tags",
        .training_specification = "TrainingSpecification",
        .validation_specification = "ValidationSpecification",
    };
};

pub const CreateAlgorithmOutput = struct {
    /// The Amazon Resource Name (ARN) of the new algorithm.
    algorithm_arn: []const u8,

    pub const json_field_names = .{
        .algorithm_arn = "AlgorithmArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAlgorithmInput, options: CallOptions) !CreateAlgorithmOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAlgorithmInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateAlgorithm");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAlgorithmOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateAlgorithmOutput, body, allocator);
}
