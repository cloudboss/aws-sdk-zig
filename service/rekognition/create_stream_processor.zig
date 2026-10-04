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

pub const CreateStreamProcessorInput = struct {
    /// Shows whether you are sharing data with Rekognition to improve model
    /// performance. You can choose this option at the account level or on a
    /// per-stream basis.
    /// Note that if you opt out at the account level this setting is ignored on
    /// individual streams.
    data_sharing_preference: ?StreamProcessorDataSharingPreference = null,

    /// Kinesis video stream stream that provides the source streaming video. If you
    /// are using the AWS CLI, the parameter name is `StreamProcessorInput`. This is
    /// required for both face search and label detection stream processors.
    input: StreamProcessorInput,

    /// The identifier for your AWS Key Management Service key (AWS KMS key). This
    /// is an optional parameter for label detection stream processors and should
    /// not be used to create a face search stream processor.
    /// You can supply the Amazon Resource Name (ARN) of your KMS key, the ID of
    /// your KMS key, an alias for your KMS key, or an alias ARN.
    /// The key is used to encrypt results and data published to your Amazon S3
    /// bucket, which includes image frames and hero images. Your source images are
    /// unaffected.
    kms_key_id: ?[]const u8 = null,

    /// An identifier you assign to the stream processor. You can use `Name` to
    /// manage the stream processor. For example, you can get the current status of
    /// the stream processor by calling DescribeStreamProcessor.
    /// `Name` is idempotent. This is required for both face search and label
    /// detection stream processors.
    name: []const u8,

    notification_channel: ?StreamProcessorNotificationChannel = null,

    /// Kinesis data stream stream or Amazon S3 bucket location to which Amazon
    /// Rekognition Video puts the analysis results. If you are using the AWS CLI,
    /// the parameter name is `StreamProcessorOutput`.
    /// This must be a S3Destination of an Amazon S3 bucket that you own for a label
    /// detection stream processor or a Kinesis data stream ARN for a face search
    /// stream processor.
    output: StreamProcessorOutput,

    /// Specifies locations in the frames where Amazon Rekognition checks for
    /// objects or people. You can specify up to 10 regions of interest, and each
    /// region has either a polygon or a bounding box. This is an optional parameter
    /// for label detection stream processors and should not be used to create a
    /// face search stream processor.
    regions_of_interest: ?[]const RegionOfInterest = null,

    /// The Amazon Resource Number (ARN) of the IAM role that allows access to the
    /// stream processor.
    /// The IAM role provides Rekognition read permissions for a Kinesis stream.
    /// It also provides write permissions to an Amazon S3 bucket and Amazon Simple
    /// Notification Service topic for a label detection stream processor. This is
    /// required for both face search and label detection stream processors.
    role_arn: []const u8,

    /// Input parameters used in a streaming video analyzed by a stream processor.
    /// You can use `FaceSearch` to recognize faces in a streaming video, or you can
    /// use `ConnectedHome` to detect labels.
    settings: StreamProcessorSettings,

    /// A set of tags (key-value pairs) that you want to attach to the stream
    /// processor.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .data_sharing_preference = "DataSharingPreference",
        .input = "Input",
        .kms_key_id = "KmsKeyId",
        .name = "Name",
        .notification_channel = "NotificationChannel",
        .output = "Output",
        .regions_of_interest = "RegionsOfInterest",
        .role_arn = "RoleArn",
        .settings = "Settings",
        .tags = "Tags",
    };
};

pub const CreateStreamProcessorOutput = struct {
    /// Amazon Resource Number for the newly created stream processor.
    stream_processor_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .stream_processor_arn = "StreamProcessorArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStreamProcessorInput, options: CallOptions) !CreateStreamProcessorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStreamProcessorInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.CreateStreamProcessor");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStreamProcessorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateStreamProcessorOutput, body, allocator);
}
