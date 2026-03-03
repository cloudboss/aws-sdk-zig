const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStreamProcessorInput, options: Options) !CreateStreamProcessorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "rekognition");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStreamProcessorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rekognition", "Rekognition", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.CreateStreamProcessor");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStreamProcessorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateStreamProcessorOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "HumanLoopQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .human_loop_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ImageTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .image_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidImageFormatException")) {
        return .{ .arena = arena, .kind = .{ .invalid_image_format_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidManifestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_manifest_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPaginationTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_pagination_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyRevisionIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_revision_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3ObjectException")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_object_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyDocumentException")) {
        return .{ .arena = arena, .kind = .{ .malformed_policy_document_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ProvisionedThroughputExceededException")) {
        return .{ .arena = arena, .kind = .{ .provisioned_throughput_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_ready_exception = .{
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
    if (std.mem.eql(u8, error_code, "SessionNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .session_not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "VideoTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .video_too_large_exception = .{
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
