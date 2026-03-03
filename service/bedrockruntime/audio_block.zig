const ErrorBlock = @import("error_block.zig").ErrorBlock;
const AudioFormat = @import("audio_format.zig").AudioFormat;
const AudioSource = @import("audio_source.zig").AudioSource;

/// An audio content block that contains audio data in various supported
/// formats.
pub const AudioBlock = struct {
    /// Error information if the audio block could not be processed or contains
    /// invalid data.
    @"error": ?ErrorBlock = null,

    /// The format of the audio data, such as MP3, WAV, FLAC, or other supported
    /// audio formats.
    format: AudioFormat,

    /// The source of the audio data, which can be provided as raw bytes or an S3
    /// location.
    source: AudioSource,

    pub const json_field_names = .{
        .@"error" = "error",
        .format = "format",
        .source = "source",
    };
};
