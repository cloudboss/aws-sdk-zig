const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MedicalScribeInputStream = @import("medical_scribe_input_stream.zig").MedicalScribeInputStream;
const MedicalScribeLanguageCode = @import("medical_scribe_language_code.zig").MedicalScribeLanguageCode;
const MedicalScribeMediaEncoding = @import("medical_scribe_media_encoding.zig").MedicalScribeMediaEncoding;
const MedicalScribeOutputStream = @import("medical_scribe_output_stream.zig").MedicalScribeOutputStream;

pub const StartMedicalScribeListeningSessionInput = struct {
    /// The Domain identifier
    domain_id: []const u8,

    input_stream: ?MedicalScribeInputStream = null,

    /// The Language Code for the audio in the session
    language_code: MedicalScribeLanguageCode,

    /// The encoding for the input audio
    media_encoding: MedicalScribeMediaEncoding,

    /// The sample rate of the input audio
    media_sample_rate_hertz: i32,

    /// The Session identifier
    session_id: []const u8,

    /// The Subscription identifier
    subscription_id: []const u8,

    pub const json_field_names = .{
        .domain_id = "domainId",
        .input_stream = "inputStream",
        .language_code = "languageCode",
        .media_encoding = "mediaEncoding",
        .media_sample_rate_hertz = "mediaSampleRateHertz",
        .session_id = "sessionId",
        .subscription_id = "subscriptionId",
    };
};

pub const StartMedicalScribeListeningSessionOutput = struct {
    /// The Domain identifier
    domain_id: ?[]const u8 = null,

    /// The Language Code for the audio in the session
    language_code: ?MedicalScribeLanguageCode = null,

    /// The encoding for the input audio
    media_encoding: ?MedicalScribeMediaEncoding = null,

    /// The sample rate of the input audio
    media_sample_rate_hertz: ?i32 = null,

    /// The Request identifier
    request_id: ?[]const u8 = null,

    /// The output stream containing transcript events
    response_stream: ?MedicalScribeOutputStream = null,

    /// The Session identifier
    session_id: ?[]const u8 = null,

    /// The Subscription identifier
    subscription_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_id = "domainId",
        .language_code = "languageCode",
        .media_encoding = "mediaEncoding",
        .media_sample_rate_hertz = "mediaSampleRateHertz",
        .request_id = "requestId",
        .response_stream = "responseStream",
        .session_id = "sessionId",
        .subscription_id = "subscriptionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMedicalScribeListeningSessionInput, options: CallOptions) !StartMedicalScribeListeningSessionOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    // Requires HTTP/2 bidirectional streaming
    return error.EventStreamNotSupported;
}
