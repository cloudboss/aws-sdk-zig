const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MedicalContentIdentificationType = @import("medical_content_identification_type.zig").MedicalContentIdentificationType;
const LanguageCode = @import("language_code.zig").LanguageCode;
const Media = @import("media.zig").Media;
const MediaFormat = @import("media_format.zig").MediaFormat;
const MedicalTranscriptionSetting = @import("medical_transcription_setting.zig").MedicalTranscriptionSetting;
const Specialty = @import("specialty.zig").Specialty;
const Tag = @import("tag.zig").Tag;
const Type = @import("type.zig").Type;
const MedicalTranscriptionJob = @import("medical_transcription_job.zig").MedicalTranscriptionJob;

pub const StartMedicalTranscriptionJobInput = struct {
    /// Labels all personal health information (PHI) identified in your transcript.
    /// For more
    /// information, see [Identifying personal health information (PHI) in a
    /// transcription](https://docs.aws.amazon.com/transcribe/latest/dg/phi-id.html).
    content_identification_type: ?MedicalContentIdentificationType = null,

    /// A map of plain text, non-secret key:value pairs, known as encryption context
    /// pairs,
    /// that provide an added layer of security for your data. For more information,
    /// see [KMS encryption
    /// context](https://docs.aws.amazon.com/transcribe/latest/dg/key-management.html#kms-context) and [Asymmetric keys in KMS](https://docs.aws.amazon.com/transcribe/latest/dg/symmetric-asymmetric.html).
    kms_encryption_context: ?[]const aws.map.StringMapEntry = null,

    /// The language code that represents the language spoken in the input media
    /// file. US
    /// English (`en-US`) is the only valid value for medical transcription jobs.
    /// Any
    /// other value you enter for language code results in a `BadRequestException`
    /// error.
    language_code: LanguageCode,

    media: Media,

    /// Specify the format of your input media file.
    media_format: ?MediaFormat = null,

    /// The sample rate, in hertz, of the audio track in your input media file.
    ///
    /// If you do not specify the media sample rate, Amazon Transcribe Medical
    /// determines it
    /// for you. If you specify the sample rate, it must match the rate detected by
    /// Amazon Transcribe Medical; if there's a mismatch between the value that you
    /// specify and the
    /// value detected, your job fails. Therefore, in most cases, it's advised to
    /// omit
    /// `MediaSampleRateHertz` and let Amazon Transcribe Medical determine the
    /// sample rate.
    media_sample_rate_hertz: ?i32 = null,

    /// A unique name, chosen by you, for your medical transcription job. The name
    /// that you
    /// specify is also used as the default name of your transcription output file.
    /// If you want
    /// to specify a different name for your transcription output, use the
    /// `OutputKey` parameter.
    ///
    /// This name is case sensitive, cannot contain spaces, and must be unique
    /// within an
    /// Amazon Web Services account. If you try to create a new job with the same
    /// name as an
    /// existing job, you get a `ConflictException` error.
    medical_transcription_job_name: []const u8,

    /// The name of the Amazon S3 bucket where you want your medical transcription
    /// output stored. Do not include the `S3://` prefix of the specified
    /// bucket.
    ///
    /// If you want your output to go to a sub-folder of this bucket, specify it
    /// using the
    /// `OutputKey` parameter; `OutputBucketName` only accepts the
    /// name of a bucket.
    ///
    /// For example, if you want your output stored in `S3://DOC-EXAMPLE-BUCKET`,
    /// set `OutputBucketName` to `DOC-EXAMPLE-BUCKET`. However, if you
    /// want your output stored in `S3://DOC-EXAMPLE-BUCKET/test-files/`, set
    /// `OutputBucketName` to `DOC-EXAMPLE-BUCKET` and
    /// `OutputKey` to `test-files/`.
    ///
    /// Note that Amazon Transcribe must have permission to use the specified
    /// location. You
    /// can change Amazon S3 permissions using the [Amazon Web Services Management
    /// Console](https://console.aws.amazon.com/s3). See also [Permissions Required
    /// for IAM User
    /// Roles](https://docs.aws.amazon.com/transcribe/latest/dg/security_iam_id-based-policy-examples.html#auth-role-iam-user).
    output_bucket_name: []const u8,

    /// The Amazon Resource Name (ARN) of a KMS key that you want to use to
    /// encrypt your medical transcription output.
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
    /// Note that the role making the request and the role specified
    /// in the `DataAccessRoleArn` request parameter (if present) must have
    /// permission to use the
    /// specified KMS key.
    output_encryption_kms_key_id: ?[]const u8 = null,

    /// Use in combination with `OutputBucketName` to specify the output location
    /// of your transcript and, optionally, a unique name for your output file. The
    /// default name
    /// for your transcription output is the same as the name you specified for your
    /// medical
    /// transcription job (`MedicalTranscriptionJobName`).
    ///
    /// Here are some examples of how you can use `OutputKey`:
    ///
    /// * If you specify 'DOC-EXAMPLE-BUCKET' as the `OutputBucketName` and
    /// 'my-transcript.json' as the `OutputKey`, your transcription output
    /// path is `s3://DOC-EXAMPLE-BUCKET/my-transcript.json`.
    ///
    /// * If you specify 'my-first-transcription' as the
    /// `MedicalTranscriptionJobName`, 'DOC-EXAMPLE-BUCKET' as the
    /// `OutputBucketName`, and 'my-transcript' as the
    /// `OutputKey`, your transcription output path is
    /// `s3://DOC-EXAMPLE-BUCKET/my-transcript/my-first-transcription.json`.
    ///
    /// * If you specify 'DOC-EXAMPLE-BUCKET' as the `OutputBucketName` and
    /// 'test-files/my-transcript.json' as the `OutputKey`, your
    /// transcription output path is
    /// `s3://DOC-EXAMPLE-BUCKET/test-files/my-transcript.json`.
    ///
    /// * If you specify 'my-first-transcription' as the
    /// `MedicalTranscriptionJobName`, 'DOC-EXAMPLE-BUCKET' as the
    /// `OutputBucketName`, and 'test-files/my-transcript' as the
    /// `OutputKey`, your transcription output path is
    /// `s3://DOC-EXAMPLE-BUCKET/test-files/my-transcript/my-first-transcription.json`.
    ///
    /// If you specify the name of an Amazon S3 bucket sub-folder that doesn't
    /// exist,
    /// one is created for you.
    output_key: ?[]const u8 = null,

    /// Specify additional optional settings in your request, including channel
    /// identification, alternative transcriptions, and speaker partitioning. You
    /// can use that to
    /// apply custom vocabularies to your transcription job.
    settings: ?MedicalTranscriptionSetting = null,

    /// Specify the predominant medical specialty represented in your media. For
    /// batch
    /// transcriptions, `PRIMARYCARE` is the only valid value. If you require
    /// additional specialties, refer to .
    specialty: Specialty,

    /// Adds one or more custom tags, each in the form of a key:value pair, to a new
    /// medical
    /// transcription job at the time you start this new job.
    ///
    /// To learn more about using tags with Amazon Transcribe, refer to [Tagging
    /// resources](https://docs.aws.amazon.com/transcribe/latest/dg/tagging.html).
    tags: ?[]const Tag = null,

    /// Specify whether your input media contains only one person (`DICTATION`) or
    /// contains a conversation between two people (`CONVERSATION`).
    ///
    /// For example, `DICTATION` could be used for a medical professional wanting
    /// to transcribe voice memos; `CONVERSATION` could be used for transcribing the
    /// doctor-patient dialogue during the patient's office visit.
    @"type": Type,

    pub const json_field_names = .{
        .content_identification_type = "ContentIdentificationType",
        .kms_encryption_context = "KMSEncryptionContext",
        .language_code = "LanguageCode",
        .media = "Media",
        .media_format = "MediaFormat",
        .media_sample_rate_hertz = "MediaSampleRateHertz",
        .medical_transcription_job_name = "MedicalTranscriptionJobName",
        .output_bucket_name = "OutputBucketName",
        .output_encryption_kms_key_id = "OutputEncryptionKMSKeyId",
        .output_key = "OutputKey",
        .settings = "Settings",
        .specialty = "Specialty",
        .tags = "Tags",
        .@"type" = "Type",
    };
};

pub const StartMedicalTranscriptionJobOutput = struct {
    /// Provides detailed information about the current medical transcription job,
    /// including
    /// job status and, if applicable, failure reason.
    medical_transcription_job: ?MedicalTranscriptionJob = null,

    pub const json_field_names = .{
        .medical_transcription_job = "MedicalTranscriptionJob",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMedicalTranscriptionJobInput, options: Options) !StartMedicalTranscriptionJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartMedicalTranscriptionJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Transcribe.StartMedicalTranscriptionJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartMedicalTranscriptionJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartMedicalTranscriptionJobOutput, body, allocator);
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
