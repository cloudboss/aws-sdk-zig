const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BatchStrategy = @import("batch_strategy.zig").BatchStrategy;
const BatchDataCaptureConfig = @import("batch_data_capture_config.zig").BatchDataCaptureConfig;
const DataProcessing = @import("data_processing.zig").DataProcessing;
const ExperimentConfig = @import("experiment_config.zig").ExperimentConfig;
const ModelClientConfig = @import("model_client_config.zig").ModelClientConfig;
const TransformInput = @import("transform_input.zig").TransformInput;
const TransformJobStatus = @import("transform_job_status.zig").TransformJobStatus;
const TransformOutput = @import("transform_output.zig").TransformOutput;
const TransformResources = @import("transform_resources.zig").TransformResources;

pub const DescribeTransformJobInput = struct {
    /// The name of the transform job that you want to view details of.
    transform_job_name: []const u8,

    pub const json_field_names = .{
        .transform_job_name = "TransformJobName",
    };
};

pub const DescribeTransformJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the AutoML transform job.
    auto_ml_job_arn: ?[]const u8 = null,

    /// Specifies the number of records to include in a mini-batch for an HTTP
    /// inference request. A *record* is a single unit of input data that inference
    /// can be made on. For example, a single line in a CSV file is a record.
    ///
    /// To enable the batch strategy, you must set `SplitType` to `Line`,
    /// `RecordIO`, or `TFRecord`.
    batch_strategy: ?BatchStrategy = null,

    /// A timestamp that shows when the transform Job was created.
    creation_time: i64,

    /// Configuration to control how SageMaker captures inference data.
    data_capture_config: ?BatchDataCaptureConfig = null,

    data_processing: ?DataProcessing = null,

    /// The environment variables to set in the Docker container. We support up to
    /// 16 key and values entries in the map.
    environment: ?[]const aws.map.StringMapEntry = null,

    experiment_config: ?ExperimentConfig = null,

    /// If the transform job failed, `FailureReason` describes why it failed. A
    /// transform job creates a log file, which includes error messages, and stores
    /// it as an Amazon S3 object. For more information, see [Log Amazon SageMaker
    /// Events with Amazon
    /// CloudWatch](https://docs.aws.amazon.com/sagemaker/latest/dg/logging-cloudwatch.html).
    failure_reason: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon SageMaker Ground Truth labeling
    /// job that created the transform or training job.
    labeling_job_arn: ?[]const u8 = null,

    /// The maximum number of parallel requests on each instance node that can be
    /// launched in a transform job. The default value is 1.
    max_concurrent_transforms: ?i32 = null,

    /// The maximum payload size, in MB, used in the transform job.
    max_payload_in_mb: ?i32 = null,

    /// The timeout and maximum number of retries for processing a transform job
    /// invocation.
    model_client_config: ?ModelClientConfig = null,

    /// The name of the model used in the transform job.
    model_name: []const u8,

    /// Indicates when the transform job has been completed, or has stopped or
    /// failed. You are billed for the time interval between this time and the value
    /// of `TransformStartTime`.
    transform_end_time: ?i64 = null,

    /// Describes the dataset to be transformed and the Amazon S3 location where it
    /// is stored.
    transform_input: ?TransformInput = null,

    /// The Amazon Resource Name (ARN) of the transform job.
    transform_job_arn: []const u8,

    /// The name of the transform job.
    transform_job_name: []const u8,

    /// The status of the transform job. If the transform job failed, the reason is
    /// returned in the `FailureReason` field.
    transform_job_status: TransformJobStatus,

    /// Identifies the Amazon S3 location where you want Amazon SageMaker to save
    /// the results from the transform job.
    transform_output: ?TransformOutput = null,

    /// Describes the resources, including ML instance types and ML instance count,
    /// to use for the transform job.
    transform_resources: ?TransformResources = null,

    /// Indicates when the transform job starts on ML instances. You are billed for
    /// the time interval between this time and the value of `TransformEndTime`.
    transform_start_time: ?i64 = null,

    pub const json_field_names = .{
        .auto_ml_job_arn = "AutoMLJobArn",
        .batch_strategy = "BatchStrategy",
        .creation_time = "CreationTime",
        .data_capture_config = "DataCaptureConfig",
        .data_processing = "DataProcessing",
        .environment = "Environment",
        .experiment_config = "ExperimentConfig",
        .failure_reason = "FailureReason",
        .labeling_job_arn = "LabelingJobArn",
        .max_concurrent_transforms = "MaxConcurrentTransforms",
        .max_payload_in_mb = "MaxPayloadInMB",
        .model_client_config = "ModelClientConfig",
        .model_name = "ModelName",
        .transform_end_time = "TransformEndTime",
        .transform_input = "TransformInput",
        .transform_job_arn = "TransformJobArn",
        .transform_job_name = "TransformJobName",
        .transform_job_status = "TransformJobStatus",
        .transform_output = "TransformOutput",
        .transform_resources = "TransformResources",
        .transform_start_time = "TransformStartTime",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTransformJobInput, options: Options) !DescribeTransformJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTransformJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeTransformJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTransformJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeTransformJobOutput, body, allocator);
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
