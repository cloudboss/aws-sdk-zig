const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InferenceInputConfiguration = @import("inference_input_configuration.zig").InferenceInputConfiguration;
const InferenceOutputConfiguration = @import("inference_output_configuration.zig").InferenceOutputConfiguration;
const DataUploadFrequency = @import("data_upload_frequency.zig").DataUploadFrequency;
const LatestInferenceResult = @import("latest_inference_result.zig").LatestInferenceResult;
const InferenceSchedulerStatus = @import("inference_scheduler_status.zig").InferenceSchedulerStatus;

pub const DescribeInferenceSchedulerInput = struct {
    /// The name of the inference scheduler being described.
    inference_scheduler_name: []const u8,

    pub const json_field_names = .{
        .inference_scheduler_name = "InferenceSchedulerName",
    };
};

pub const DescribeInferenceSchedulerOutput = struct {
    /// Specifies the time at which the inference scheduler was created.
    created_at: ?i64 = null,

    /// A period of time (in minutes) by which inference on the data is delayed
    /// after the data
    /// starts. For instance, if you select an offset delay time of five minutes,
    /// inference will
    /// not begin on the data until the first data measurement after the five minute
    /// mark. For
    /// example, if five minutes is selected, the inference scheduler will wake up
    /// at the
    /// configured frequency with the additional five minute delay time to check the
    /// customer S3
    /// bucket. The customer can upload data at the same frequency and they don't
    /// need to stop and
    /// restart the scheduler when uploading new data.
    data_delay_offset_in_minutes: ?i64 = null,

    /// Specifies configuration information for the input data for the inference
    /// scheduler,
    /// including delimiter, format, and dataset location.
    data_input_configuration: ?InferenceInputConfiguration = null,

    /// Specifies information for the output results for the inference scheduler,
    /// including
    /// the output S3 location.
    data_output_configuration: ?InferenceOutputConfiguration = null,

    /// Specifies how often data is uploaded to the source S3 bucket for the input
    /// data. This
    /// value is the length of time between data uploads. For instance, if you
    /// select 5 minutes,
    /// Amazon Lookout for Equipment will upload the real-time data to the source
    /// bucket once every 5 minutes. This
    /// frequency also determines how often Amazon Lookout for Equipment starts a
    /// scheduled inference on your data. In
    /// this example, it starts once every 5 minutes.
    data_upload_frequency: ?DataUploadFrequency = null,

    /// The Amazon Resource Name (ARN) of the inference scheduler being described.
    inference_scheduler_arn: ?[]const u8 = null,

    /// The name of the inference scheduler being described.
    inference_scheduler_name: ?[]const u8 = null,

    /// Indicates whether the latest execution for the inference scheduler was
    /// Anomalous
    /// (anomalous events found) or Normal (no anomalous events found).
    latest_inference_result: ?LatestInferenceResult = null,

    /// The Amazon Resource Name (ARN) of the machine learning model of the
    /// inference scheduler
    /// being described.
    model_arn: ?[]const u8 = null,

    /// The name of the machine learning model of the inference scheduler being
    /// described.
    model_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of a role with permission to access the data
    /// source for
    /// the inference scheduler being described.
    role_arn: ?[]const u8 = null,

    /// Provides the identifier of the KMS key used to encrypt inference scheduler
    /// data by
    /// Amazon Lookout for Equipment.
    server_side_kms_key_id: ?[]const u8 = null,

    /// Indicates the status of the inference scheduler.
    status: ?InferenceSchedulerStatus = null,

    /// Specifies the time at which the inference scheduler was last updated, if it
    /// was.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .data_delay_offset_in_minutes = "DataDelayOffsetInMinutes",
        .data_input_configuration = "DataInputConfiguration",
        .data_output_configuration = "DataOutputConfiguration",
        .data_upload_frequency = "DataUploadFrequency",
        .inference_scheduler_arn = "InferenceSchedulerArn",
        .inference_scheduler_name = "InferenceSchedulerName",
        .latest_inference_result = "LatestInferenceResult",
        .model_arn = "ModelArn",
        .model_name = "ModelName",
        .role_arn = "RoleArn",
        .server_side_kms_key_id = "ServerSideKmsKeyId",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInferenceSchedulerInput, options: Options) !DescribeInferenceSchedulerOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeInferenceSchedulerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lookoutequipment", "LookoutEquipment", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.DescribeInferenceScheduler");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeInferenceSchedulerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeInferenceSchedulerOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
