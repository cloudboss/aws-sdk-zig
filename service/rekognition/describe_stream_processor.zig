const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamProcessorDataSharingPreference = @import("stream_processor_data_sharing_preference.zig").StreamProcessorDataSharingPreference;
const StreamProcessorInput = @import("stream_processor_input.zig").StreamProcessorInput;
const StreamProcessorNotificationChannel = @import("stream_processor_notification_channel.zig").StreamProcessorNotificationChannel;
const StreamProcessorOutput = @import("stream_processor_output.zig").StreamProcessorOutput;
const RegionOfInterest = @import("region_of_interest.zig").RegionOfInterest;
const StreamProcessorSettings = @import("stream_processor_settings.zig").StreamProcessorSettings;
const StreamProcessorStatus = @import("stream_processor_status.zig").StreamProcessorStatus;

pub const DescribeStreamProcessorInput = struct {
    /// Name of the stream processor for which you want information.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const DescribeStreamProcessorOutput = struct {
    /// Date and time the stream processor was created
    creation_timestamp: ?i64 = null,

    /// Shows whether you are sharing data with Rekognition to improve model
    /// performance. You can choose this option at the account level or on a
    /// per-stream basis.
    /// Note that if you opt out at the account level this setting is ignored on
    /// individual streams.
    data_sharing_preference: ?StreamProcessorDataSharingPreference = null,

    /// Kinesis video stream that provides the source streaming video.
    input: ?StreamProcessorInput = null,

    /// The identifier for your AWS Key Management Service key (AWS KMS key). This
    /// is an optional parameter for label detection stream processors.
    kms_key_id: ?[]const u8 = null,

    /// The time, in Unix format, the stream processor was last updated. For
    /// example, when the stream
    /// processor moves from a running state to a failed state, or when the user
    /// starts or stops the stream processor.
    last_update_timestamp: ?i64 = null,

    /// Name of the stream processor.
    name: ?[]const u8 = null,

    notification_channel: ?StreamProcessorNotificationChannel = null,

    /// Kinesis data stream to which Amazon Rekognition Video puts the analysis
    /// results.
    output: ?StreamProcessorOutput = null,

    /// Specifies locations in the frames where Amazon Rekognition checks for
    /// objects or people. This is an optional parameter for label detection stream
    /// processors.
    regions_of_interest: ?[]const RegionOfInterest = null,

    /// ARN of the IAM role that allows access to the stream processor.
    role_arn: ?[]const u8 = null,

    /// Input parameters used in a streaming video analyzed by a stream processor.
    /// You can use `FaceSearch` to recognize faces
    /// in a streaming video, or you can use `ConnectedHome` to detect labels.
    settings: ?StreamProcessorSettings = null,

    /// Current status of the stream processor.
    status: ?StreamProcessorStatus = null,

    /// Detailed status message about the stream processor.
    status_message: ?[]const u8 = null,

    /// ARN of the stream processor.
    stream_processor_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_timestamp = "CreationTimestamp",
        .data_sharing_preference = "DataSharingPreference",
        .input = "Input",
        .kms_key_id = "KmsKeyId",
        .last_update_timestamp = "LastUpdateTimestamp",
        .name = "Name",
        .notification_channel = "NotificationChannel",
        .output = "Output",
        .regions_of_interest = "RegionsOfInterest",
        .role_arn = "RoleArn",
        .settings = "Settings",
        .status = "Status",
        .status_message = "StatusMessage",
        .stream_processor_arn = "StreamProcessorArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeStreamProcessorInput, options: CallOptions) !DescribeStreamProcessorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rekognition", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeStreamProcessorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rekognition", "Rekognition", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.DescribeStreamProcessor");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeStreamProcessorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeStreamProcessorOutput, body, allocator);
}
