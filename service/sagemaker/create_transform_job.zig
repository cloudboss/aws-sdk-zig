const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const BatchStrategy = @import("batch_strategy.zig").BatchStrategy;
const BatchDataCaptureConfig = @import("batch_data_capture_config.zig").BatchDataCaptureConfig;
const DataProcessing = @import("data_processing.zig").DataProcessing;
const ExperimentConfig = @import("experiment_config.zig").ExperimentConfig;
const ModelClientConfig = @import("model_client_config.zig").ModelClientConfig;
const Tag = @import("tag.zig").Tag;
const TransformInput = @import("transform_input.zig").TransformInput;
const TransformOutput = @import("transform_output.zig").TransformOutput;
const TransformResources = @import("transform_resources.zig").TransformResources;

pub const CreateTransformJobInput = struct {
    /// Specifies the number of records to include in a mini-batch for an HTTP
    /// inference request. A *record* is a single unit of input data that inference
    /// can be made on. For example, a single line in a CSV file is a record.
    ///
    /// To enable the batch strategy, you must set the `SplitType` property to
    /// `Line`, `RecordIO`, or `TFRecord`.
    ///
    /// To use only one record when making an HTTP invocation request to a
    /// container, set `BatchStrategy` to `SingleRecord` and `SplitType` to `Line`.
    ///
    /// To fit as many records in a mini-batch as can fit within the
    /// `MaxPayloadInMB` limit, set `BatchStrategy` to `MultiRecord` and `SplitType`
    /// to `Line`.
    batch_strategy: ?BatchStrategy = null,

    /// Configuration to control how SageMaker captures inference data.
    data_capture_config: ?BatchDataCaptureConfig = null,

    /// The data structure used to specify the data to be used for inference in a
    /// batch transform job and to associate the data that is relevant to the
    /// prediction results in the output. The input filter provided allows you to
    /// exclude input data that is not needed for inference in a batch transform
    /// job. The output filter provided allows you to include input data relevant to
    /// interpreting the predictions in the output from the job. For more
    /// information, see [Associate Prediction Results with their Corresponding
    /// Input
    /// Records](https://docs.aws.amazon.com/sagemaker/latest/dg/batch-transform-data-processing.html).
    data_processing: ?DataProcessing = null,

    /// The environment variables to set in the Docker container. Don't include any
    /// sensitive data in your environment variables. We support up to 16 key and
    /// values entries in the map.
    environment: ?[]const aws.map.StringMapEntry = null,

    experiment_config: ?ExperimentConfig = null,

    /// The maximum number of parallel requests that can be sent to each instance in
    /// a transform job. If `MaxConcurrentTransforms` is set to `0` or left unset,
    /// Amazon SageMaker checks the optional execution-parameters to determine the
    /// settings for your chosen algorithm. If the execution-parameters endpoint is
    /// not enabled, the default value is `1`. For more information on
    /// execution-parameters, see [How Containers Serve
    /// Requests](https://docs.aws.amazon.com/sagemaker/latest/dg/your-algorithms-batch-code.html#your-algorithms-batch-code-how-containe-serves-requests). For built-in algorithms, you don't need to set a value for `MaxConcurrentTransforms`.
    max_concurrent_transforms: ?i32 = null,

    /// The maximum allowed size of the payload, in MB. A *payload* is the data
    /// portion of a record (without metadata). The value in `MaxPayloadInMB` must
    /// be greater than, or equal to, the size of a single record. To estimate the
    /// size of a record in MB, divide the size of your dataset by the number of
    /// records. To ensure that the records fit within the maximum payload size, we
    /// recommend using a slightly larger value. The default value is `6` MB.
    ///
    /// The value of `MaxPayloadInMB` cannot be greater than 100 MB. If you specify
    /// the `MaxConcurrentTransforms` parameter, the value of
    /// `(MaxConcurrentTransforms * MaxPayloadInMB)` also cannot exceed 100 MB.
    ///
    /// For cases where the payload might be arbitrarily large and is transmitted
    /// using HTTP chunked encoding, set the value to `0`. This feature works only
    /// in supported algorithms. Currently, Amazon SageMaker built-in algorithms do
    /// not support HTTP chunked encoding.
    max_payload_in_mb: ?i32 = null,

    /// Configures the timeout and maximum number of retries for processing a
    /// transform job invocation.
    model_client_config: ?ModelClientConfig = null,

    /// The name of the model that you want to use for the transform job.
    /// `ModelName` must be the name of an existing Amazon SageMaker model within an
    /// Amazon Web Services Region in an Amazon Web Services account.
    model_name: []const u8,

    /// (Optional) An array of key-value pairs. For more information, see [Using
    /// Cost Allocation
    /// Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html#allocation-what) in the *Amazon Web Services Billing and Cost Management User Guide*.
    tags: ?[]const Tag = null,

    /// Describes the input source and the way the transform job consumes it.
    transform_input: TransformInput,

    /// The name of the transform job. The name must be unique within an Amazon Web
    /// Services Region in an Amazon Web Services account.
    transform_job_name: []const u8,

    /// Describes the results of the transform job.
    transform_output: TransformOutput,

    /// Describes the resources, including ML instance types and ML instance count,
    /// to use for the transform job.
    transform_resources: TransformResources,

    pub const json_field_names = .{
        .batch_strategy = "BatchStrategy",
        .data_capture_config = "DataCaptureConfig",
        .data_processing = "DataProcessing",
        .environment = "Environment",
        .experiment_config = "ExperimentConfig",
        .max_concurrent_transforms = "MaxConcurrentTransforms",
        .max_payload_in_mb = "MaxPayloadInMB",
        .model_client_config = "ModelClientConfig",
        .model_name = "ModelName",
        .tags = "Tags",
        .transform_input = "TransformInput",
        .transform_job_name = "TransformJobName",
        .transform_output = "TransformOutput",
        .transform_resources = "TransformResources",
    };
};

pub const CreateTransformJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the transform job.
    transform_job_arn: []const u8,

    pub const json_field_names = .{
        .transform_job_arn = "TransformJobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTransformJobInput, options: CallOptions) !CreateTransformJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTransformJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateTransformJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTransformJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateTransformJobOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
