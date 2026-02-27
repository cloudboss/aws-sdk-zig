const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Engine = @import("engine.zig").Engine;
const LanguageCode = @import("language_code.zig").LanguageCode;
const OutputFormat = @import("output_format.zig").OutputFormat;
const SpeechMarkType = @import("speech_mark_type.zig").SpeechMarkType;
const TextType = @import("text_type.zig").TextType;
const VoiceId = @import("voice_id.zig").VoiceId;
const SynthesisTask = @import("synthesis_task.zig").SynthesisTask;

pub const StartSpeechSynthesisTaskInput = struct {
    /// Specifies the engine (`standard`, `neural`,
    /// `long-form` or `generative`) for Amazon Polly to use
    /// when processing input text for speech synthesis. Using a voice that
    /// is not supported for the engine selected will result in an error.
    engine: ?Engine = null,

    /// Optional language code for the Speech Synthesis request. This is only
    /// necessary if using a bilingual voice, such as Aditi, which can be used for
    /// either Indian English (en-IN) or Hindi (hi-IN).
    ///
    /// If a bilingual voice is used and no language code is specified, Amazon Polly
    /// uses the default language of the bilingual voice. The default language for
    /// any voice is the one returned by the
    /// [DescribeVoices](https://docs.aws.amazon.com/polly/latest/dg/API_DescribeVoices.html) operation for the `LanguageCode`
    /// parameter. For example, if no language code is specified, Aditi will use
    /// Indian English rather than Hindi.
    language_code: ?LanguageCode = null,

    /// List of one or more pronunciation lexicon names you want the service
    /// to apply during synthesis. Lexicons are applied only if the language of
    /// the lexicon is the same as the language of the voice.
    lexicon_names: ?[]const []const u8 = null,

    /// The format in which the returned output will be encoded. For audio
    /// stream, this will be mp3, ogg_vorbis, or pcm. For speech marks, this will
    /// be json.
    output_format: OutputFormat,

    /// Amazon S3 bucket name to which the output file will be saved.
    output_s3_bucket_name: []const u8,

    /// The Amazon S3 key prefix for the output speech file.
    output_s3_key_prefix: ?[]const u8 = null,

    /// The audio frequency specified in Hz.
    ///
    /// The valid values for mp3 and ogg_vorbis are "8000", "16000", "22050",
    /// and "24000". The default value for standard voices is "22050". The default
    /// value for neural voices is "24000". The default value for long-form voices
    /// is "24000". The default value for generative voices is "24000".
    ///
    /// Valid values for pcm are "8000" and "16000" The default value is
    /// "16000".
    sample_rate: ?[]const u8 = null,

    /// ARN for the SNS topic optionally used for providing status
    /// notification for a speech synthesis task.
    sns_topic_arn: ?[]const u8 = null,

    /// The type of speech marks returned for the input text.
    speech_mark_types: ?[]const SpeechMarkType = null,

    /// The input text to synthesize. If you specify ssml as the TextType,
    /// follow the SSML format for the input text.
    text: []const u8,

    /// Specifies whether the input text is plain text or SSML. The default
    /// value is plain text.
    text_type: ?TextType = null,

    /// Voice ID to use for the synthesis.
    voice_id: VoiceId,

    pub const json_field_names = .{
        .engine = "Engine",
        .language_code = "LanguageCode",
        .lexicon_names = "LexiconNames",
        .output_format = "OutputFormat",
        .output_s3_bucket_name = "OutputS3BucketName",
        .output_s3_key_prefix = "OutputS3KeyPrefix",
        .sample_rate = "SampleRate",
        .sns_topic_arn = "SnsTopicArn",
        .speech_mark_types = "SpeechMarkTypes",
        .text = "Text",
        .text_type = "TextType",
        .voice_id = "VoiceId",
    };
};

pub const StartSpeechSynthesisTaskOutput = struct {
    /// SynthesisTask object that provides information and attributes about a
    /// newly submitted speech synthesis task.
    synthesis_task: ?SynthesisTask = null,

    pub const json_field_names = .{
        .synthesis_task = "SynthesisTask",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSpeechSynthesisTaskInput, options: Options) !StartSpeechSynthesisTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "polly");

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

fn serializeRequest(alloc: std.mem.Allocator, input: StartSpeechSynthesisTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("polly", "Polly", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/synthesisTasks";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.engine) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Engine\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.language_code) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"LanguageCode\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.lexicon_names) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"LexiconNames\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"OutputFormat\":");
    try aws.json.writeValue(@TypeOf(input.output_format), input.output_format, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"OutputS3BucketName\":");
    try aws.json.writeValue(@TypeOf(input.output_s3_bucket_name), input.output_s3_bucket_name, alloc, &body_buf);
    has_prev = true;
    if (input.output_s3_key_prefix) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"OutputS3KeyPrefix\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.sample_rate) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SampleRate\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.sns_topic_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SnsTopicArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.speech_mark_types) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SpeechMarkTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Text\":");
    try aws.json.writeValue(@TypeOf(input.text), input.text, alloc, &body_buf);
    has_prev = true;
    if (input.text_type) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"TextType\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"VoiceId\":");
    try aws.json.writeValue(@TypeOf(input.voice_id), input.voice_id, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartSpeechSynthesisTaskOutput {
    var result: StartSpeechSynthesisTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartSpeechSynthesisTaskOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "EngineNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .engine_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLexiconException")) {
        return .{ .arena = arena, .kind = .{ .invalid_lexicon_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3BucketException")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_bucket_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3KeyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_key_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSampleRateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sample_rate_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSnsTopicArnException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sns_topic_arn_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSsmlException")) {
        return .{ .arena = arena, .kind = .{ .invalid_ssml_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTaskIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_task_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LanguageNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .language_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LexiconNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .lexicon_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LexiconSizeExceededException")) {
        return .{ .arena = arena, .kind = .{ .lexicon_size_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MarksNotSupportedForFormatException")) {
        return .{ .arena = arena, .kind = .{ .marks_not_supported_for_format_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaxLexemeLengthExceededException")) {
        return .{ .arena = arena, .kind = .{ .max_lexeme_length_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaxLexiconsNumberExceededException")) {
        return .{ .arena = arena, .kind = .{ .max_lexicons_number_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceFailureException")) {
        return .{ .arena = arena, .kind = .{ .service_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SsmlMarksNotSupportedForTextTypeException")) {
        return .{ .arena = arena, .kind = .{ .ssml_marks_not_supported_for_text_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SynthesisTaskNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .synthesis_task_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TextLengthExceededException")) {
        return .{ .arena = arena, .kind = .{ .text_length_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedPlsAlphabetException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_pls_alphabet_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedPlsLanguageException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_pls_language_exception = .{
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
