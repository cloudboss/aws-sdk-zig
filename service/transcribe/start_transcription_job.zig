const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ContentRedaction = @import("content_redaction.zig").ContentRedaction;
const JobExecutionSettings = @import("job_execution_settings.zig").JobExecutionSettings;
const LanguageCode = @import("language_code.zig").LanguageCode;
const LanguageIdSettings = @import("language_id_settings.zig").LanguageIdSettings;
const Media = @import("media.zig").Media;
const MediaFormat = @import("media_format.zig").MediaFormat;
const ModelSettings = @import("model_settings.zig").ModelSettings;
const Settings = @import("settings.zig").Settings;
const Subtitles = @import("subtitles.zig").Subtitles;
const Tag = @import("tag.zig").Tag;
const ToxicityDetectionSettings = @import("toxicity_detection_settings.zig").ToxicityDetectionSettings;
const TranscriptionJob = @import("transcription_job.zig").TranscriptionJob;

pub const StartTranscriptionJobInput = struct {
    /// Makes it possible to redact or flag specified personally identifiable
    /// information (PII) in
    /// your transcript. If you use `ContentRedaction`, you must also include the
    /// sub-parameters: `RedactionOutput` and `RedactionType`. You can
    /// optionally include `PiiEntityTypes` to choose which types of PII you want to
    /// redact.
    /// If you do not include `PiiEntityTypes` in your request, all PII is redacted.
    content_redaction: ?ContentRedaction = null,

    /// Enables automatic language identification in your transcription job request.
    /// Use this
    /// parameter if your media file contains only one language. If your media
    /// contains multiple
    /// languages, use `IdentifyMultipleLanguages` instead.
    ///
    /// If you include `IdentifyLanguage`, you can optionally include a list of
    /// language codes, using `LanguageOptions`, that you think may be present in
    /// your media file. Including `LanguageOptions` restricts
    /// `IdentifyLanguage` to only the language options that you specify, which
    /// can improve transcription accuracy.
    ///
    /// If you want to apply a custom language model, a custom vocabulary, or a
    /// custom
    /// vocabulary filter to your automatic language identification request, include
    /// `LanguageIdSettings` with the relevant sub-parameters
    /// (`VocabularyName`, `LanguageModelName`, and
    /// `VocabularyFilterName`). If you include `LanguageIdSettings`,
    /// also include `LanguageOptions`.
    ///
    /// Note that you must include one of `LanguageCode`,
    /// `IdentifyLanguage`, or `IdentifyMultipleLanguages` in your
    /// request. If you include more than one of these parameters, your
    /// transcription job
    /// fails.
    identify_language: ?bool = null,

    /// Enables automatic multi-language identification in your transcription job
    /// request. Use
    /// this parameter if your media file contains more than one language. If your
    /// media
    /// contains only one language, use `IdentifyLanguage` instead.
    ///
    /// If you include `IdentifyMultipleLanguages`, you can optionally include a
    /// list of language codes, using `LanguageOptions`, that you think may be
    /// present in your media file. Including `LanguageOptions` restricts
    /// `IdentifyLanguage` to only the language options that you specify, which
    /// can improve transcription accuracy.
    ///
    /// If you want to apply a custom vocabulary or a custom vocabulary filter to
    /// your
    /// automatic language identification request, include `LanguageIdSettings` with
    /// the relevant sub-parameters (`VocabularyName` and
    /// `VocabularyFilterName`). If you include `LanguageIdSettings`,
    /// also include `LanguageOptions`.
    ///
    /// Note that you must include one of `LanguageCode`,
    /// `IdentifyLanguage`, or `IdentifyMultipleLanguages` in your
    /// request. If you include more than one of these parameters, your
    /// transcription job
    /// fails.
    identify_multiple_languages: ?bool = null,

    /// Makes it possible to control how your transcription job is processed.
    /// Currently, the
    /// only `JobExecutionSettings` modification you can choose is enabling job
    /// queueing using the `AllowDeferredExecution` sub-parameter.
    ///
    /// If you include `JobExecutionSettings` in your request, you must also
    /// include the sub-parameters: `AllowDeferredExecution` and
    /// `DataAccessRoleArn`.
    job_execution_settings: ?JobExecutionSettings = null,

    /// A map of plain text, non-secret key:value pairs, known as encryption context
    /// pairs,
    /// that provide an added layer of security for your data. For more information,
    /// see [KMS encryption
    /// context](https://docs.aws.amazon.com/transcribe/latest/dg/key-management.html#kms-context) and [Asymmetric keys in KMS](https://docs.aws.amazon.com/transcribe/latest/dg/symmetric-asymmetric.html).
    kms_encryption_context: ?[]const aws.map.StringMapEntry = null,

    /// The language code that represents the language spoken in the input media
    /// file.
    ///
    /// If you're unsure of the language spoken in your media file, consider using
    /// `IdentifyLanguage` or `IdentifyMultipleLanguages` to enable
    /// automatic language identification.
    ///
    /// Note that you must include one of `LanguageCode`,
    /// `IdentifyLanguage`, or `IdentifyMultipleLanguages` in your
    /// request. If you include more than one of these parameters, your
    /// transcription job
    /// fails.
    ///
    /// For a list of supported languages and their associated language codes, refer
    /// to the
    /// [Supported
    /// languages](https://docs.aws.amazon.com/transcribe/latest/dg/supported-languages.html) table.
    ///
    /// To transcribe speech in Modern Standard Arabic (`ar-SA`) in Amazon Web
    /// Services GovCloud (US) (US-West, us-gov-west-1), Amazon Web Services
    /// GovCloud (US) (US-East, us-gov-east-1), Canada (Calgary, ca-west-1) and
    /// Africa (Cape Town, af-south-1), your media
    /// file must be encoded at a sample rate of 16,000 Hz or higher.
    language_code: ?LanguageCode = null,

    /// If using automatic language identification in your request and you want to
    /// apply a
    /// custom language model, a custom vocabulary, or a custom vocabulary filter,
    /// include
    /// `LanguageIdSettings` with the relevant sub-parameters
    /// (`VocabularyName`, `LanguageModelName`, and
    /// `VocabularyFilterName`). Note that multi-language identification
    /// (`IdentifyMultipleLanguages`) doesn't support custom language
    /// models.
    ///
    /// `LanguageIdSettings` supports two to five language codes. Each language
    /// code you include can have an associated custom language model, custom
    /// vocabulary, and
    /// custom vocabulary filter. The language codes that you specify must match the
    /// languages
    /// of the associated custom language models, custom vocabularies, and custom
    /// vocabulary
    /// filters.
    ///
    /// It's recommended that you include `LanguageOptions` when using
    /// `LanguageIdSettings` to ensure that the correct language dialect is
    /// identified. For example, if you specify a custom vocabulary that is in
    /// `en-US` but Amazon Transcribe determines that the language spoken in
    /// your media is `en-AU`, your custom vocabulary *is not*
    /// applied to your transcription. If you include `LanguageOptions` and include
    /// `en-US` as the only English language dialect, your custom vocabulary
    /// *is* applied to your transcription.
    ///
    /// If you want to include a custom language model with your request but **do
    /// not** want to use automatic language identification, use
    /// instead the `` parameter with the
    /// `LanguageModelName` sub-parameter. If you want to include a custom
    /// vocabulary or a custom vocabulary filter (or both) with your request but
    /// **do not** want to use automatic language identification, use
    /// instead the `` parameter with the
    /// `VocabularyName` or `VocabularyFilterName` (or both)
    /// sub-parameter.
    language_id_settings: ?[]const aws.map.MapEntry(LanguageIdSettings) = null,

    /// You can specify two or more language codes that represent the languages you
    /// think may
    /// be present in your media. Including more than five is not recommended. If
    /// you're unsure
    /// what languages are present, do not include this parameter.
    ///
    /// If you include `LanguageOptions` in your request, you must also include
    /// `IdentifyLanguage`.
    ///
    /// For more information, refer to [Supported
    /// languages](https://docs.aws.amazon.com/transcribe/latest/dg/supported-languages.html).
    ///
    /// To transcribe speech in Modern Standard Arabic (`ar-SA`)in Amazon Web
    /// Services GovCloud (US) (US-West, us-gov-west-1), Amazon Web Services
    /// GovCloud (US) (US-East, us-gov-east-1), in Canada (Calgary) ca-west-1 and
    /// Africa (Cape Town) af-south-1, your media file
    /// must be encoded at a sample rate of 16,000 Hz or higher.
    language_options: ?[]const LanguageCode = null,

    /// Describes the Amazon S3 location of the media file you want to use in your
    /// request.
    media: Media,

    /// Specify the format of your input media file.
    media_format: ?MediaFormat = null,

    /// The sample rate, in hertz, of the audio track in your input media file.
    ///
    /// If you do not specify the media sample rate, Amazon Transcribe determines it
    /// for you.
    /// If you specify the sample rate, it must match the rate detected by Amazon
    /// Transcribe.
    /// If there's a mismatch between the value that you specify and the value
    /// detected, your
    /// job fails. In most cases, you can omit `MediaSampleRateHertz` and let Amazon
    /// Transcribe determine the sample rate.
    media_sample_rate_hertz: ?i32 = null,

    /// Specify the custom language model you want to include with your
    /// transcription job. If
    /// you include `ModelSettings` in your request, you must include the
    /// `LanguageModelName` sub-parameter.
    ///
    /// For more information, see [Custom language
    /// models](https://docs.aws.amazon.com/transcribe/latest/dg/custom-language-models.html).
    model_settings: ?ModelSettings = null,

    /// The name of the Amazon S3 bucket where you want your transcription output
    /// stored. Do not include the `S3://` prefix of the specified bucket.
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
    ///
    /// If you do not specify `OutputBucketName`, your transcript is placed in a
    /// service-managed Amazon S3 bucket and you are provided with a URI to access
    /// your
    /// transcript.
    output_bucket_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of a KMS key that you want to use to
    /// encrypt your transcription output.
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
    /// Note that the role making the request and the role specified in the
    /// `DataAccessRoleArn` request parameter (if present) must have permission to
    /// use the specified
    /// KMS key.
    output_encryption_kms_key_id: ?[]const u8 = null,

    /// Use in combination with `OutputBucketName` to specify the output location
    /// of your transcript and, optionally, a unique name for your output file. The
    /// default name
    /// for your transcription output is the same as the name you specified for your
    /// transcription job (`TranscriptionJobName`).
    ///
    /// Here are some examples of how you can use `OutputKey`:
    ///
    /// * If you specify 'DOC-EXAMPLE-BUCKET' as the `OutputBucketName` and
    /// 'my-transcript.json' as the `OutputKey`, your transcription output
    /// path is `s3://DOC-EXAMPLE-BUCKET/my-transcript.json`.
    ///
    /// * If you specify 'my-first-transcription' as the
    /// `TranscriptionJobName`, 'DOC-EXAMPLE-BUCKET' as the
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
    /// `TranscriptionJobName`, 'DOC-EXAMPLE-BUCKET' as the
    /// `OutputBucketName`, and 'test-files/my-transcript' as the
    /// `OutputKey`, your transcription output path is
    /// `s3://DOC-EXAMPLE-BUCKET/test-files/my-transcript/my-first-transcription.json`.
    ///
    /// If you specify the name of an Amazon S3 bucket sub-folder that doesn't
    /// exist,
    /// one is created for you.
    output_key: ?[]const u8 = null,

    /// Specify additional optional settings in your
    /// request, including channel identification, alternative transcriptions,
    /// speaker
    /// partitioning. You can use that to apply custom vocabularies and vocabulary
    /// filters.
    ///
    /// If you want to include a custom vocabulary or a custom vocabulary filter (or
    /// both)
    /// with your request but **do not** want to use automatic
    /// language identification, use `Settings` with the `VocabularyName`
    /// or `VocabularyFilterName` (or both) sub-parameter.
    ///
    /// If you're using automatic language identification with your request and want
    /// to
    /// include a custom language model, a custom vocabulary, or a custom vocabulary
    /// filter, use
    /// instead the `` parameter with the
    /// `LanguageModelName`, `VocabularyName` or
    /// `VocabularyFilterName` sub-parameters.
    settings: ?Settings = null,

    /// Produces subtitle files for your input media. You can specify WebVTT (*.vtt)
    /// and
    /// SubRip (*.srt) formats.
    subtitles: ?Subtitles = null,

    /// Adds one or more custom tags, each in the form of a key:value pair, to a new
    /// transcription job at the time you start this new job.
    ///
    /// To learn more about using tags with Amazon Transcribe, refer to [Tagging
    /// resources](https://docs.aws.amazon.com/transcribe/latest/dg/tagging.html).
    tags: ?[]const Tag = null,

    /// Enables toxic speech detection in your transcript. If you include
    /// `ToxicityDetection` in your request, you must also include
    /// `ToxicityCategories`.
    ///
    /// For information on the types of toxic speech Amazon Transcribe can detect,
    /// see
    /// [Detecting toxic
    /// speech](https://docs.aws.amazon.com/transcribe/latest/dg/toxic-language.html).
    toxicity_detection: ?[]const ToxicityDetectionSettings = null,

    /// A unique name, chosen by you, for your transcription job. The name that you
    /// specify is
    /// also used as the default name of your transcription output file. If you want
    /// to specify
    /// a different name for your transcription output, use the `OutputKey`
    /// parameter.
    ///
    /// This name is case sensitive, cannot contain spaces, and must be unique
    /// within an
    /// Amazon Web Services account. If you try to create a new job with the same
    /// name as an
    /// existing job, you get a `ConflictException` error.
    transcription_job_name: []const u8,

    pub const json_field_names = .{
        .content_redaction = "ContentRedaction",
        .identify_language = "IdentifyLanguage",
        .identify_multiple_languages = "IdentifyMultipleLanguages",
        .job_execution_settings = "JobExecutionSettings",
        .kms_encryption_context = "KMSEncryptionContext",
        .language_code = "LanguageCode",
        .language_id_settings = "LanguageIdSettings",
        .language_options = "LanguageOptions",
        .media = "Media",
        .media_format = "MediaFormat",
        .media_sample_rate_hertz = "MediaSampleRateHertz",
        .model_settings = "ModelSettings",
        .output_bucket_name = "OutputBucketName",
        .output_encryption_kms_key_id = "OutputEncryptionKMSKeyId",
        .output_key = "OutputKey",
        .settings = "Settings",
        .subtitles = "Subtitles",
        .tags = "Tags",
        .toxicity_detection = "ToxicityDetection",
        .transcription_job_name = "TranscriptionJobName",
    };
};

pub const StartTranscriptionJobOutput = struct {
    /// Provides detailed information about the current transcription job, including
    /// job
    /// status and, if applicable, failure reason.
    transcription_job: ?TranscriptionJob = null,

    pub const json_field_names = .{
        .transcription_job = "TranscriptionJob",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartTranscriptionJobInput, options: Options) !StartTranscriptionJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartTranscriptionJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Transcribe.StartTranscriptionJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartTranscriptionJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartTranscriptionJobOutput, body, allocator);
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
