const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInferenceSchedulerInput, options: CallOptions) !DescribeInferenceSchedulerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lookoutequipment", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInferenceSchedulerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lookoutequipment", "LookoutEquipment", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.DescribeInferenceScheduler");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInferenceSchedulerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeInferenceSchedulerOutput, body, allocator);
}
