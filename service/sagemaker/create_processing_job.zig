const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppSpecification = @import("app_specification.zig").AppSpecification;
const ExperimentConfig = @import("experiment_config.zig").ExperimentConfig;
const NetworkConfig = @import("network_config.zig").NetworkConfig;
const ProcessingInput = @import("processing_input.zig").ProcessingInput;
const ProcessingOutputConfig = @import("processing_output_config.zig").ProcessingOutputConfig;
const ProcessingResources = @import("processing_resources.zig").ProcessingResources;
const ProcessingStoppingCondition = @import("processing_stopping_condition.zig").ProcessingStoppingCondition;
const Tag = @import("tag.zig").Tag;

pub const CreateProcessingJobInput = struct {
    /// Configures the processing job to run a specified Docker container image.
    app_specification: AppSpecification,

    /// The environment variables to set in the Docker container. Up to 100 key and
    /// values entries in the map are supported.
    ///
    /// Do not include any security-sensitive information including account access
    /// IDs, secrets, or tokens in any environment fields. As part of the shared
    /// responsibility model, you are responsible for any potential exposure,
    /// unauthorized access, or compromise of your sensitive data if caused by
    /// security-sensitive information included in the request environment variable
    /// or plain text fields.
    environment: ?[]const aws.map.StringMapEntry = null,

    experiment_config: ?ExperimentConfig = null,

    /// Networking options for a processing job, such as whether to allow inbound
    /// and outbound network calls to and from processing containers, and the VPC
    /// subnets and security groups to use for VPC-enabled processing jobs.
    network_config: ?NetworkConfig = null,

    /// An array of inputs configuring the data to download into the processing
    /// container.
    processing_inputs: ?[]const ProcessingInput = null,

    /// The name of the processing job. The name must be unique within an Amazon Web
    /// Services Region in the Amazon Web Services account.
    processing_job_name: []const u8,

    /// Output configuration for the processing job.
    processing_output_config: ?ProcessingOutputConfig = null,

    /// Identifies the resources, ML compute instances, and ML storage volumes to
    /// deploy for a processing job. In distributed training, you specify more than
    /// one instance.
    processing_resources: ProcessingResources,

    /// The Amazon Resource Name (ARN) of an IAM role that Amazon SageMaker can
    /// assume to perform tasks on your behalf.
    role_arn: []const u8,

    /// The time limit for how long the processing job is allowed to run.
    stopping_condition: ?ProcessingStoppingCondition = null,

    /// (Optional) An array of key-value pairs. For more information, see [Using
    /// Cost Allocation
    /// Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html#allocation-whatURL) in the *Amazon Web Services Billing and Cost Management User Guide*.
    ///
    /// Do not include any security-sensitive information including account access
    /// IDs, secrets, or tokens in any tags. As part of the shared responsibility
    /// model, you are responsible for any potential exposure, unauthorized access,
    /// or compromise of your sensitive data if caused by security-sensitive
    /// information included in the request tag variable or plain text fields.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .app_specification = "AppSpecification",
        .environment = "Environment",
        .experiment_config = "ExperimentConfig",
        .network_config = "NetworkConfig",
        .processing_inputs = "ProcessingInputs",
        .processing_job_name = "ProcessingJobName",
        .processing_output_config = "ProcessingOutputConfig",
        .processing_resources = "ProcessingResources",
        .role_arn = "RoleArn",
        .stopping_condition = "StoppingCondition",
        .tags = "Tags",
    };
};

pub const CreateProcessingJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the processing job.
    processing_job_arn: []const u8,

    pub const json_field_names = .{
        .processing_job_arn = "ProcessingJobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProcessingJobInput, options: CallOptions) !CreateProcessingJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProcessingJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateProcessingJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProcessingJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateProcessingJobOutput, body, allocator);
}
