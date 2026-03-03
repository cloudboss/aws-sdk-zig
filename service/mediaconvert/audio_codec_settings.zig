const AacSettings = @import("aac_settings.zig").AacSettings;
const Ac3Settings = @import("ac_3_settings.zig").Ac3Settings;
const AiffSettings = @import("aiff_settings.zig").AiffSettings;
const AudioCodec = @import("audio_codec.zig").AudioCodec;
const Eac3AtmosSettings = @import("eac_3_atmos_settings.zig").Eac3AtmosSettings;
const Eac3Settings = @import("eac_3_settings.zig").Eac3Settings;
const FlacSettings = @import("flac_settings.zig").FlacSettings;
const Mp2Settings = @import("mp_2_settings.zig").Mp2Settings;
const Mp3Settings = @import("mp_3_settings.zig").Mp3Settings;
const OpusSettings = @import("opus_settings.zig").OpusSettings;
const VorbisSettings = @import("vorbis_settings.zig").VorbisSettings;
const WavSettings = @import("wav_settings.zig").WavSettings;

/// Settings related to audio encoding. The settings in this group vary
/// depending on the value that you choose for your audio codec.
pub const AudioCodecSettings = struct {
    /// Required when you set Codec to the value AAC. The service accepts one of two
    /// mutually exclusive groups of AAC settings--VBR and CBR. To select one of
    /// these modes, set the value of Bitrate control mode to "VBR" or "CBR". In VBR
    /// mode, you control the audio quality with the setting VBR quality. In CBR
    /// mode, you use the setting Bitrate. Defaults and valid values depend on the
    /// rate control mode.
    aac_settings: ?AacSettings = null,

    /// Required when you set Codec to the value AC3.
    ac_3_settings: ?Ac3Settings = null,

    /// Required when you set Codec to the value AIFF.
    aiff_settings: ?AiffSettings = null,

    /// Choose the audio codec for this output. Note that the option Dolby Digital
    /// passthrough applies only to Dolby Digital and Dolby Digital Plus audio
    /// inputs. Make sure that you choose a codec that's supported with your output
    /// container:
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/reference-codecs-containers.html#reference-codecs-containers-output-audio For audio-only outputs, make sure that both your input audio codec and your output audio codec are supported for audio-only workflows. For more information, see: https://docs.aws.amazon.com/mediaconvert/latest/ug/reference-codecs-containers-input.html#reference-codecs-containers-input-audio-only and https://docs.aws.amazon.com/mediaconvert/latest/ug/reference-codecs-containers.html#audio-only-output
    codec: ?AudioCodec = null,

    /// Required when you set Codec to the value EAC3_ATMOS.
    eac_3_atmos_settings: ?Eac3AtmosSettings = null,

    /// Required when you set Codec to the value EAC3.
    eac_3_settings: ?Eac3Settings = null,

    /// Required when you set Codec, under AudioDescriptions>CodecSettings, to the
    /// value FLAC.
    flac_settings: ?FlacSettings = null,

    /// Required when you set Codec to the value MP2.
    mp_2_settings: ?Mp2Settings = null,

    /// Required when you set Codec, under AudioDescriptions>CodecSettings, to the
    /// value MP3.
    mp_3_settings: ?Mp3Settings = null,

    /// Required when you set Codec, under AudioDescriptions>CodecSettings, to the
    /// value OPUS.
    opus_settings: ?OpusSettings = null,

    /// Required when you set Codec, under AudioDescriptions>CodecSettings, to the
    /// value Vorbis.
    vorbis_settings: ?VorbisSettings = null,

    /// Required when you set Codec to the value WAV.
    wav_settings: ?WavSettings = null,

    pub const json_field_names = .{
        .aac_settings = "AacSettings",
        .ac_3_settings = "Ac3Settings",
        .aiff_settings = "AiffSettings",
        .codec = "Codec",
        .eac_3_atmos_settings = "Eac3AtmosSettings",
        .eac_3_settings = "Eac3Settings",
        .flac_settings = "FlacSettings",
        .mp_2_settings = "Mp2Settings",
        .mp_3_settings = "Mp3Settings",
        .opus_settings = "OpusSettings",
        .vorbis_settings = "VorbisSettings",
        .wav_settings = "WavSettings",
    };
};
