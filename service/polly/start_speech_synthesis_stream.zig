const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const StartSpeechSynthesisStreamActionStream = @import("start_speech_synthesis_stream_action_stream.zig").StartSpeechSynthesisStreamActionStream;
const Engine = @import("engine.zig").Engine;
const LanguageCode = @import("language_code.zig").LanguageCode;
const OutputFormat = @import("output_format.zig").OutputFormat;
const VoiceId = @import("voice_id.zig").VoiceId;
const StartSpeechSynthesisStreamEventStream = @import("start_speech_synthesis_stream_event_stream.zig").StartSpeechSynthesisStreamEventStream;

pub const StartSpeechSynthesisStreamInput = struct {
    /// The input event stream that contains text events and stream control events.
    action_stream: ?StartSpeechSynthesisStreamActionStream = null,

    /// Specifies the engine for Amazon Polly to use when processing input text for
    /// speech synthesis.
    /// Currently, only the `generative` engine is supported.
    /// If you specify a voice that the selected engine doesn't support, Amazon
    /// Polly returns an error.
    engine: Engine,

    /// An optional parameter that sets the language code for the speech synthesis
    /// request. Specify this parameter only
    /// when using a bilingual voice. If a bilingual voice is used and no language
    /// code is specified, Amazon Polly
    /// uses the default language of the bilingual voice.
    language_code: ?LanguageCode = null,

    /// The names of one or more pronunciation lexicons for the service to apply
    /// during synthesis. Amazon Polly applies lexicons only when the lexicon
    /// language matches the voice language.
    lexicon_names: ?[]const []const u8 = null,

    /// The audio format for the synthesized speech. Currently, Amazon Polly does
    /// not support JSON speech marks.
    output_format: OutputFormat,

    /// The audio frequency, specified in Hz.
    sample_rate: ?[]const u8 = null,

    /// The voice to use in synthesis. To get a list of available voice IDs, use the
    /// [DescribeVoices](https://docs.aws.amazon.com/polly/latest/API/API_DescribeVoices.html) operation.
    voice_id: VoiceId,

    pub const json_field_names = .{
        .action_stream = "ActionStream",
        .engine = "Engine",
        .language_code = "LanguageCode",
        .lexicon_names = "LexiconNames",
        .output_format = "OutputFormat",
        .sample_rate = "SampleRate",
        .voice_id = "VoiceId",
    };
};

pub const StartSpeechSynthesisStreamOutput = struct {
    /// The output event stream that contains synthesized audio events and stream
    /// status events.
    event_stream: ?StartSpeechSynthesisStreamEventStream = null,

    pub const json_field_names = .{
        .event_stream = "EventStream",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSpeechSynthesisStreamInput, options: CallOptions) !StartSpeechSynthesisStreamOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    // Requires HTTP/2 bidirectional streaming
    return error.EventStreamNotSupported;
}
