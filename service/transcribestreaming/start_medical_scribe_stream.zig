const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const MedicalScribeInputStream = @import("medical_scribe_input_stream.zig").MedicalScribeInputStream;
const MedicalScribeLanguageCode = @import("medical_scribe_language_code.zig").MedicalScribeLanguageCode;
const MedicalScribeMediaEncoding = @import("medical_scribe_media_encoding.zig").MedicalScribeMediaEncoding;
const MedicalScribeResultStream = @import("medical_scribe_result_stream.zig").MedicalScribeResultStream;

pub const StartMedicalScribeStreamInput = struct {
    /// Specify the input stream where you will send events in real time.
    ///
    /// The first element of the input stream must be a
    /// `MedicalScribeConfigurationEvent`.
    input_stream: MedicalScribeInputStream,

    /// Specify the language code for your HealthScribe streaming session.
    language_code: MedicalScribeLanguageCode,

    /// Specify the encoding used for the input audio.
    ///
    /// Supported formats are:
    ///
    /// * FLAC
    ///
    /// * OPUS-encoded audio in an Ogg container
    ///
    /// * PCM (only signed 16-bit little-endian audio formats, which does not
    ///   include
    /// WAV)
    ///
    /// For more information, see [Media
    /// formats](https://docs.aws.amazon.com/transcribe/latest/dg/how-input.html#how-input-audio).
    media_encoding: MedicalScribeMediaEncoding,

    /// Specify the sample rate of the input audio (in hertz).
    /// Amazon Web Services HealthScribe supports a range from 16,000 Hz to 48,000
    /// Hz.
    /// The sample rate you specify must match that of your audio.
    media_sample_rate_hertz: i32,

    /// Specify an identifier for your streaming session (in UUID format).
    /// If you don't include a SessionId in your request,
    /// Amazon Web Services HealthScribe generates an ID and returns it in the
    /// response.
    session_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .input_stream = "InputStream",
        .language_code = "LanguageCode",
        .media_encoding = "MediaEncoding",
        .media_sample_rate_hertz = "MediaSampleRateHertz",
        .session_id = "SessionId",
    };
};

pub const StartMedicalScribeStreamOutput = struct {
    /// The Language Code that you specified in your request.
    /// Same as provided in the `StartMedicalScribeStreamRequest`.
    language_code: ?MedicalScribeLanguageCode = null,

    /// The Media Encoding you specified in your request.
    /// Same as provided in the
    /// `StartMedicalScribeStreamRequest`
    media_encoding: ?MedicalScribeMediaEncoding = null,

    /// The sample rate (in hertz) that you specified in your request.
    /// Same as provided in the
    /// `StartMedicalScribeStreamRequest`
    media_sample_rate_hertz: ?i32 = null,

    /// The unique identifier for your streaming request.
    request_id: ?[]const u8 = null,

    /// The result stream where you will receive the output events.
    result_stream: ?MedicalScribeResultStream = null,

    /// The identifier (in UUID format) for your streaming session.
    ///
    /// If you already started streaming, this is same ID as the one you specified
    /// in your initial `StartMedicalScribeStreamRequest`.
    session_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .media_encoding = "MediaEncoding",
        .media_sample_rate_hertz = "MediaSampleRateHertz",
        .request_id = "RequestId",
        .result_stream = "ResultStream",
        .session_id = "SessionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMedicalScribeStreamInput, options: CallOptions) !StartMedicalScribeStreamOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    // Requires HTTP/2 bidirectional streaming
    return error.EventStreamNotSupported;
}
