const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ChannelDefinition = @import("channel_definition.zig").ChannelDefinition;
const Media = @import("media.zig").Media;
const CallAnalyticsJobSettings = @import("call_analytics_job_settings.zig").CallAnalyticsJobSettings;
const Tag = @import("tag.zig").Tag;
const CallAnalyticsJob = @import("call_analytics_job.zig").CallAnalyticsJob;

pub const StartCallAnalyticsJobInput = struct {
    /// A unique name, chosen by you, for your Call Analytics job.
    ///
    /// This name is case sensitive, cannot contain spaces, and must be unique
    /// within an
    /// Amazon Web Services account. If you try to create a new job with the same
    /// name as an
    /// existing job, you get a `ConflictException` error.
    call_analytics_job_name: []const u8,

    /// Makes it possible to specify which speaker is on which channel. For example,
    /// if your
    /// agent is the first participant to speak, you would set `ChannelId` to
    /// `0` (to indicate the first channel) and `ParticipantRole` to
    /// `AGENT` (to indicate that it's the agent speaking).
    channel_definitions: ?[]const ChannelDefinition = null,

    /// The Amazon Resource Name (ARN) of an IAM role that has permissions to
    /// access the Amazon S3 bucket that contains your input files. If the role that
    /// you
    /// specify doesn’t have the appropriate permissions to access the specified
    /// Amazon S3 location, your request fails.
    ///
    /// IAM role ARNs have the format
    /// `arn:partition:iam::account:role/role-name-with-path`. For example:
    /// `arn:aws:iam::111122223333:role/Admin`.
    ///
    /// For more information, see [IAM
    /// ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns).
    data_access_role_arn: ?[]const u8 = null,

    /// Describes the Amazon S3 location of the media file you want to use in your
    /// Call Analytics request.
    media: Media,

    /// The Amazon Resource Name (ARN) of a KMS key that you want to use to
    /// encrypt your Call Analytics output.
    ///
    /// KMS key ARNs have the format `arn:partition:kms:region:account:key/key-id`.
    /// For example:
    /// `arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`.
    /// For more information, see [
    /// KMS key
    /// ARNs](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN).
    ///
    /// If you do not specify an encryption key, your output is encrypted with the
    /// default
    /// Amazon S3 key (SSE-S3).
    ///
    /// Note that the role making the request and the role specified in
    /// the `DataAccessRoleArn` request parameter (if present) must have permission
    /// to use the
    /// specified KMS key.
    output_encryption_kms_key_id: ?[]const u8 = null,

    /// The Amazon S3 location where you want your Call Analytics transcription
    /// output
    /// stored. You can use any of the following formats to specify the output
    /// location:
    ///
    /// * s3://DOC-EXAMPLE-BUCKET
    ///
    /// * s3://DOC-EXAMPLE-BUCKET/my-output-folder/
    ///
    /// * s3://DOC-EXAMPLE-BUCKET/my-output-folder/my-call-analytics-job.json
    ///
    /// Unless you specify a file name (option 3), the name of your output file has
    /// a default
    /// value that matches the name you specified for your transcription job using
    /// the
    /// `CallAnalyticsJobName` parameter.
    ///
    /// You can specify a KMS key to encrypt your output using the
    /// `OutputEncryptionKMSKeyId` parameter. If you do not specify a KMS key,
    /// Amazon Transcribe uses the default Amazon S3 key for
    /// server-side encryption.
    ///
    /// If you do not specify `OutputLocation`, your transcript is placed in a
    /// service-managed Amazon S3 bucket and you are provided with a URI to access
    /// your
    /// transcript.
    output_location: ?[]const u8 = null,

    /// Specify additional optional settings in your request, including content
    /// redaction; allows you to apply custom language models,
    /// vocabulary filters, and custom vocabularies to your Call Analytics job.
    settings: ?CallAnalyticsJobSettings = null,

    /// Adds one or more custom tags, each in the form of a key:value pair, to a new
    /// call analytics job at the time you start this new job.
    ///
    /// To learn more about using tags with Amazon Transcribe, refer to [Tagging
    /// resources](https://docs.aws.amazon.com/transcribe/latest/dg/tagging.html).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .call_analytics_job_name = "CallAnalyticsJobName",
        .channel_definitions = "ChannelDefinitions",
        .data_access_role_arn = "DataAccessRoleArn",
        .media = "Media",
        .output_encryption_kms_key_id = "OutputEncryptionKMSKeyId",
        .output_location = "OutputLocation",
        .settings = "Settings",
        .tags = "Tags",
    };
};

pub const StartCallAnalyticsJobOutput = struct {
    /// Provides detailed information about the current Call Analytics job,
    /// including job
    /// status and, if applicable, failure reason.
    call_analytics_job: ?CallAnalyticsJob = null,

    pub const json_field_names = .{
        .call_analytics_job = "CallAnalyticsJob",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartCallAnalyticsJobInput, options: Options) !StartCallAnalyticsJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "transcribe");

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartCallAnalyticsJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transcribe", "Transcribe", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "Transcribe.StartCallAnalyticsJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartCallAnalyticsJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartCallAnalyticsJobOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
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
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
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
