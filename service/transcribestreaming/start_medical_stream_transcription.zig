const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AudioStream = @import("audio_stream.zig").AudioStream;
const MedicalContentIdentificationType = @import("medical_content_identification_type.zig").MedicalContentIdentificationType;
const LanguageCode = @import("language_code.zig").LanguageCode;
const MediaEncoding = @import("media_encoding.zig").MediaEncoding;
const Specialty = @import("specialty.zig").Specialty;
const Type = @import("type.zig").Type;
const MedicalTranscriptResultStream = @import("medical_transcript_result_stream.zig").MedicalTranscriptResultStream;

pub const StartMedicalStreamTranscriptionInput = struct {
    audio_stream: AudioStream,

    /// Labels all personal health information (PHI) identified in your transcript.
    ///
    /// Content identification is performed at the segment level; PHI is flagged
    /// upon complete
    /// transcription of an audio segment.
    ///
    /// For more information, see [Identifying personal health information (PHI) in
    /// a
    /// transcription](https://docs.aws.amazon.com/transcribe/latest/dg/phi-id.html).
    content_identification_type: ?MedicalContentIdentificationType = null,

    /// Enables channel identification in multi-channel audio.
    ///
    /// Channel identification transcribes the audio on each channel independently,
    /// then appends
    /// the output for each channel into one transcript.
    ///
    /// If you have multi-channel audio and do not enable channel identification,
    /// your audio is
    /// transcribed in a continuous manner and your transcript is not separated by
    /// channel.
    ///
    /// If you include `EnableChannelIdentification` in your request, you must also
    /// include `NumberOfChannels`.
    ///
    /// For more information, see [Transcribing multi-channel
    /// audio](https://docs.aws.amazon.com/transcribe/latest/dg/channel-id.html).
    enable_channel_identification: bool = false,

    /// Specify the language code that represents the language spoken in your audio.
    ///
    /// Amazon Transcribe Medical only supports US English (`en-US`).
    language_code: LanguageCode,

    /// Specify the encoding used for the input audio. Supported formats are:
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
    media_encoding: MediaEncoding,

    /// The sample rate of the input audio (in hertz). Amazon Transcribe Medical
    /// supports a
    /// range from 16,000 Hz to 48,000 Hz. Note that the sample rate you specify
    /// must match that
    /// of your audio.
    media_sample_rate_hertz: i32,

    /// Specify the number of channels in your audio stream. This value must be
    /// `2`, as only two channels are supported. If your audio doesn't contain
    /// multiple channels, do not include this parameter in your request.
    ///
    /// If you include `NumberOfChannels` in your request, you must also
    /// include `EnableChannelIdentification`.
    number_of_channels: ?i32 = null,

    /// Specify a name for your transcription session. If you don't include this
    /// parameter in
    /// your request, Amazon Transcribe Medical generates an ID and returns it in
    /// the
    /// response.
    session_id: ?[]const u8 = null,

    /// Enables speaker partitioning (diarization) in your transcription output.
    /// Speaker
    /// partitioning labels the speech from individual speakers in your media file.
    ///
    /// For more information, see [Partitioning speakers
    /// (diarization)](https://docs.aws.amazon.com/transcribe/latest/dg/diarization.html).
    show_speaker_label: bool = false,

    /// Specify the medical specialty contained in your audio.
    specialty: Specialty,

    /// Specify the type of input audio. For example, choose `DICTATION` for a
    /// provider dictating patient notes and `CONVERSATION` for a dialogue between a
    /// patient and a medical professional.
    @"type": Type,

    /// Specify the name of the custom vocabulary that you want to use when
    /// processing your
    /// transcription. Note that vocabulary names are case sensitive.
    vocabulary_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .audio_stream = "AudioStream",
        .content_identification_type = "ContentIdentificationType",
        .enable_channel_identification = "EnableChannelIdentification",
        .language_code = "LanguageCode",
        .media_encoding = "MediaEncoding",
        .media_sample_rate_hertz = "MediaSampleRateHertz",
        .number_of_channels = "NumberOfChannels",
        .session_id = "SessionId",
        .show_speaker_label = "ShowSpeakerLabel",
        .specialty = "Specialty",
        .@"type" = "Type",
        .vocabulary_name = "VocabularyName",
    };
};

pub const StartMedicalStreamTranscriptionOutput = struct {
    /// Shows whether content identification was enabled for your transcription.
    content_identification_type: ?MedicalContentIdentificationType = null,

    /// Shows whether channel identification was enabled for your transcription.
    enable_channel_identification: bool = false,

    /// Provides the language code that you specified in your request. This must be
    /// `en-US`.
    language_code: ?LanguageCode = null,

    /// Provides the media encoding you specified in your request.
    media_encoding: ?MediaEncoding = null,

    /// Provides the sample rate that you specified in your request.
    media_sample_rate_hertz: ?i32 = null,

    /// Provides the number of channels that you specified in your request.
    number_of_channels: ?i32 = null,

    /// Provides the identifier for your streaming request.
    request_id: ?[]const u8 = null,

    /// Provides the identifier for your transcription session.
    session_id: ?[]const u8 = null,

    /// Shows whether speaker partitioning was enabled for your transcription.
    show_speaker_label: bool = false,

    /// Provides the medical specialty that you specified in your request.
    specialty: ?Specialty = null,

    /// Provides detailed information about your streaming session.
    transcript_result_stream: ?MedicalTranscriptResultStream = null,

    /// Provides the type of audio you specified in your request.
    @"type": ?Type = null,

    /// Provides the name of the custom vocabulary that you specified in your
    /// request.
    vocabulary_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .content_identification_type = "ContentIdentificationType",
        .enable_channel_identification = "EnableChannelIdentification",
        .language_code = "LanguageCode",
        .media_encoding = "MediaEncoding",
        .media_sample_rate_hertz = "MediaSampleRateHertz",
        .number_of_channels = "NumberOfChannels",
        .request_id = "RequestId",
        .session_id = "SessionId",
        .show_speaker_label = "ShowSpeakerLabel",
        .specialty = "Specialty",
        .transcript_result_stream = "TranscriptResultStream",
        .@"type" = "Type",
        .vocabulary_name = "VocabularyName",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMedicalStreamTranscriptionInput, options: Options) !StartMedicalStreamTranscriptionOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    return error.EventStreamNotSupported;
}
