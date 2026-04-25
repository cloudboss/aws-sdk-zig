const std = @import("std");

/// Choose the audio codec for this output. Note that the option Dolby Digital
/// passthrough applies only to Dolby Digital and Dolby Digital Plus audio
/// inputs. Make sure that you choose a codec that's supported with your output
/// container:
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/reference-codecs-containers.html#reference-codecs-containers-output-audio For audio-only outputs, make sure that both your input audio codec and your output audio codec are supported for audio-only workflows. For more information, see: https://docs.aws.amazon.com/mediaconvert/latest/ug/reference-codecs-containers-input.html#reference-codecs-containers-input-audio-only and https://docs.aws.amazon.com/mediaconvert/latest/ug/reference-codecs-containers.html#audio-only-output
pub const AudioCodec = enum {
    aac,
    mp2,
    mp3,
    wav,
    aiff,
    ac3,
    ac4,
    eac3,
    eac3_atmos,
    vorbis,
    opus,
    passthrough,
    flac,

    pub const json_field_names = .{
        .aac = "AAC",
        .mp2 = "MP2",
        .mp3 = "MP3",
        .wav = "WAV",
        .aiff = "AIFF",
        .ac3 = "AC3",
        .ac4 = "AC4",
        .eac3 = "EAC3",
        .eac3_atmos = "EAC3_ATMOS",
        .vorbis = "VORBIS",
        .opus = "OPUS",
        .passthrough = "PASSTHROUGH",
        .flac = "FLAC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aac => "AAC",
            .mp2 => "MP2",
            .mp3 => "MP3",
            .wav => "WAV",
            .aiff => "AIFF",
            .ac3 => "AC3",
            .ac4 => "AC4",
            .eac3 => "EAC3",
            .eac3_atmos => "EAC3_ATMOS",
            .vorbis => "VORBIS",
            .opus => "OPUS",
            .passthrough => "PASSTHROUGH",
            .flac => "FLAC",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
