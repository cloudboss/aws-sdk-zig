const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AlgorithmStatus = @import("algorithm_status.zig").AlgorithmStatus;
const AlgorithmStatusDetails = @import("algorithm_status_details.zig").AlgorithmStatusDetails;
const InferenceSpecification = @import("inference_specification.zig").InferenceSpecification;
const TrainingSpecification = @import("training_specification.zig").TrainingSpecification;
const AlgorithmValidationSpecification = @import("algorithm_validation_specification.zig").AlgorithmValidationSpecification;

pub const DescribeAlgorithmInput = struct {
    /// The name of the algorithm to describe.
    algorithm_name: []const u8,

    pub const json_field_names = .{
        .algorithm_name = "AlgorithmName",
    };
};

pub const DescribeAlgorithmOutput = struct {
    /// The Amazon Resource Name (ARN) of the algorithm.
    algorithm_arn: []const u8,

    /// A brief summary about the algorithm.
    algorithm_description: ?[]const u8 = null,

    /// The name of the algorithm being described.
    algorithm_name: []const u8,

    /// The current status of the algorithm.
    algorithm_status: AlgorithmStatus,

    /// Details about the current status of the algorithm.
    algorithm_status_details: ?AlgorithmStatusDetails = null,

    /// Whether the algorithm is certified to be listed in Amazon Web Services
    /// Marketplace.
    certify_for_marketplace: ?bool = null,

    /// A timestamp specifying when the algorithm was created.
    creation_time: i64,

    /// Details about inference jobs that the algorithm runs.
    inference_specification: ?InferenceSpecification = null,

    /// The product identifier of the algorithm.
    product_id: ?[]const u8 = null,

    /// Details about training jobs run by this algorithm.
    training_specification: ?TrainingSpecification = null,

    /// Details about configurations for one or more training jobs that SageMaker
    /// runs to test the algorithm.
    validation_specification: ?AlgorithmValidationSpecification = null,

    pub const json_field_names = .{
        .algorithm_arn = "AlgorithmArn",
        .algorithm_description = "AlgorithmDescription",
        .algorithm_name = "AlgorithmName",
        .algorithm_status = "AlgorithmStatus",
        .algorithm_status_details = "AlgorithmStatusDetails",
        .certify_for_marketplace = "CertifyForMarketplace",
        .creation_time = "CreationTime",
        .inference_specification = "InferenceSpecification",
        .product_id = "ProductId",
        .training_specification = "TrainingSpecification",
        .validation_specification = "ValidationSpecification",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAlgorithmInput, options: CallOptions) !DescribeAlgorithmOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAlgorithmInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeAlgorithm");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAlgorithmOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeAlgorithmOutput, body, allocator);
}
