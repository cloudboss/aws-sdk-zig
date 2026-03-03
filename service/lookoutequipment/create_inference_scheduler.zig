const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const InferenceInputConfiguration = @import("inference_input_configuration.zig").InferenceInputConfiguration;
const InferenceOutputConfiguration = @import("inference_output_configuration.zig").InferenceOutputConfiguration;
const DataUploadFrequency = @import("data_upload_frequency.zig").DataUploadFrequency;
const Tag = @import("tag.zig").Tag;
const ModelQuality = @import("model_quality.zig").ModelQuality;
const InferenceSchedulerStatus = @import("inference_scheduler_status.zig").InferenceSchedulerStatus;

pub const CreateInferenceSchedulerInput = struct {
    /// A unique identifier for the request. If you do not set the client request
    /// token, Amazon
    /// Lookout for Equipment generates one.
    client_token: []const u8,

    /// The interval (in minutes) of planned delay at the start of each inference
    /// segment. For
    /// example, if inference is set to run every ten minutes, the delay is set to
    /// five minutes and
    /// the time is 09:08. The inference scheduler will wake up at the configured
    /// interval (which,
    /// without a delay configured, would be 09:10) plus the additional five minute
    /// delay time (so
    /// 09:15) to check your Amazon S3 bucket. The delay provides a buffer for you
    /// to upload data at the
    /// same frequency, so that you don't have to stop and restart the scheduler
    /// when uploading new
    /// data.
    ///
    /// For more information, see [Understanding
    /// the inference
    /// process](https://docs.aws.amazon.com/lookout-for-equipment/latest/ug/understanding-inference-process.html).
    data_delay_offset_in_minutes: ?i64 = null,

    /// Specifies configuration information for the input data for the inference
    /// scheduler,
    /// including delimiter, format, and dataset location.
    data_input_configuration: InferenceInputConfiguration,

    /// Specifies configuration information for the output results for the inference
    /// scheduler,
    /// including the S3 location for the output.
    data_output_configuration: InferenceOutputConfiguration,

    /// How often data is uploaded to the source Amazon S3 bucket for the input
    /// data. The value
    /// chosen is the length of time between data uploads. For instance, if you
    /// select 5 minutes,
    /// Amazon Lookout for Equipment will upload the real-time data to the source
    /// bucket once every 5 minutes. This
    /// frequency also determines how often Amazon Lookout for Equipment runs
    /// inference on your data.
    ///
    /// For more information, see [Understanding
    /// the inference
    /// process](https://docs.aws.amazon.com/lookout-for-equipment/latest/ug/understanding-inference-process.html).
    data_upload_frequency: DataUploadFrequency,

    /// The name of the inference scheduler being created.
    inference_scheduler_name: []const u8,

    /// The name of the previously trained machine learning model being used to
    /// create the
    /// inference scheduler.
    model_name: []const u8,

    /// The Amazon Resource Name (ARN) of a role with permission to access the data
    /// source being
    /// used for the inference.
    role_arn: []const u8,

    /// Provides the identifier of the KMS key used to encrypt inference scheduler
    /// data by
    /// Amazon Lookout for Equipment.
    server_side_kms_key_id: ?[]const u8 = null,

    /// Any tags associated with the inference scheduler.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .data_delay_offset_in_minutes = "DataDelayOffsetInMinutes",
        .data_input_configuration = "DataInputConfiguration",
        .data_output_configuration = "DataOutputConfiguration",
        .data_upload_frequency = "DataUploadFrequency",
        .inference_scheduler_name = "InferenceSchedulerName",
        .model_name = "ModelName",
        .role_arn = "RoleArn",
        .server_side_kms_key_id = "ServerSideKmsKeyId",
        .tags = "Tags",
    };
};

pub const CreateInferenceSchedulerOutput = struct {
    /// The Amazon Resource Name (ARN) of the inference scheduler being created.
    inference_scheduler_arn: ?[]const u8 = null,

    /// The name of inference scheduler being created.
    inference_scheduler_name: ?[]const u8 = null,

    /// Provides a quality assessment for a model that uses labels.
    /// If Lookout for Equipment determines that the
    /// model quality is poor based on training metrics, the value is
    /// `POOR_QUALITY_DETECTED`. Otherwise, the value is
    /// `QUALITY_THRESHOLD_MET`.
    ///
    /// If the model is unlabeled, the model quality can't
    /// be assessed and the value of `ModelQuality` is
    /// `CANNOT_DETERMINE_QUALITY`. In this situation, you can get a model quality
    /// assessment by adding labels to the input dataset and retraining the model.
    ///
    /// For information about using labels with your models, see [Understanding
    /// labeling](https://docs.aws.amazon.com/lookout-for-equipment/latest/ug/understanding-labeling.html).
    ///
    /// For information about improving the quality of a model, see [Best practices
    /// with
    /// Amazon Lookout for
    /// Equipment](https://docs.aws.amazon.com/lookout-for-equipment/latest/ug/best-practices.html).
    model_quality: ?ModelQuality = null,

    /// Indicates the status of the `CreateInferenceScheduler` operation.
    status: ?InferenceSchedulerStatus = null,

    pub const json_field_names = .{
        .inference_scheduler_arn = "InferenceSchedulerArn",
        .inference_scheduler_name = "InferenceSchedulerName",
        .model_quality = "ModelQuality",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInferenceSchedulerInput, options: CallOptions) !CreateInferenceSchedulerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lookoutequipment");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateInferenceSchedulerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lookoutequipment", "LookoutEquipment", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.CreateInferenceScheduler");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateInferenceSchedulerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateInferenceSchedulerOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
