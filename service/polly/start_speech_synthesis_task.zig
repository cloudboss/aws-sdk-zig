const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    /// stream, this will be mp3, ogg_vorbis, ogg_opus, mu-law, a-law, or pcm. For
    /// speech marks, this will
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
    ///
    /// Valid value for ogg_opus is "48000".
    ///
    /// Valid value for mu-law and a-law is "8000".
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSpeechSynthesisTaskInput, options: CallOptions) !StartSpeechSynthesisTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "polly", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartSpeechSynthesisTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("polly", "Polly", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/synthesisTasks";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.engine) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Engine\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.language_code) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LanguageCode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.lexicon_names) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LexiconNames\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OutputFormat\":");
    try aws.json.writeValue(@TypeOf(input.output_format), input.output_format, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OutputS3BucketName\":");
    try aws.json.writeValue(@TypeOf(input.output_s3_bucket_name), input.output_s3_bucket_name, allocator, &body_buf);
    has_prev = true;
    if (input.output_s3_key_prefix) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OutputS3KeyPrefix\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sample_rate) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SampleRate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sns_topic_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SnsTopicArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.speech_mark_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SpeechMarkTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Text\":");
    try aws.json.writeValue(@TypeOf(input.text), input.text, allocator, &body_buf);
    has_prev = true;
    if (input.text_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TextType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"VoiceId\":");
    try aws.json.writeValue(@TypeOf(input.voice_id), input.voice_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartSpeechSynthesisTaskOutput {
    var result: StartSpeechSynthesisTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartSpeechSynthesisTaskOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
