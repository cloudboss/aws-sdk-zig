const AacAudioDescriptionBroadcasterMix = @import("aac_audio_description_broadcaster_mix.zig").AacAudioDescriptionBroadcasterMix;
const AacCodecProfile = @import("aac_codec_profile.zig").AacCodecProfile;
const AacCodingMode = @import("aac_coding_mode.zig").AacCodingMode;
const AacLoudnessMeasurementMode = @import("aac_loudness_measurement_mode.zig").AacLoudnessMeasurementMode;
const AacRateControlMode = @import("aac_rate_control_mode.zig").AacRateControlMode;
const AacRawFormat = @import("aac_raw_format.zig").AacRawFormat;
const AacSpecification = @import("aac_specification.zig").AacSpecification;
const AacVbrQuality = @import("aac_vbr_quality.zig").AacVbrQuality;

/// Required when you set Codec to the value AAC. The service accepts one of two
/// mutually exclusive groups of AAC settings--VBR and CBR. To select one of
/// these modes, set the value of Bitrate control mode to "VBR" or "CBR". In VBR
/// mode, you control the audio quality with the setting VBR quality. In CBR
/// mode, you use the setting Bitrate. Defaults and valid values depend on the
/// rate control mode.
pub const AacSettings = struct {
    /// Choose BROADCASTER_MIXED_AD when the input contains pre-mixed main audio +
    /// audio description (AD) as a stereo pair. The value for AudioType will be set
    /// to 3, which signals to downstream systems that this stream contains
    /// "broadcaster mixed AD". Note that the input received by the encoder must
    /// contain pre-mixed audio; the encoder does not perform the mixing. When you
    /// choose BROADCASTER_MIXED_AD, the encoder ignores any values you provide in
    /// AudioType and FollowInputAudioType. Choose NORMAL when the input does not
    /// contain pre-mixed audio + audio description (AD). In this case, the encoder
    /// will use any values you provide for AudioType and FollowInputAudioType.
    audio_description_broadcaster_mix: ?AacAudioDescriptionBroadcasterMix,

    /// Specify the average bitrate in bits per second. The set of valid values for
    /// this setting is: 6000, 8000, 10000, 12000, 14000, 16000, 20000, 24000,
    /// 28000, 32000, 40000, 48000, 56000, 64000, 80000, 96000, 112000, 128000,
    /// 160000, 192000, 224000, 256000, 288000, 320000, 384000, 448000, 512000,
    /// 576000, 640000, 768000, 896000, 1024000. The value you set is also
    /// constrained by the values that you choose for Profile, Bitrate control mode,
    /// and Sample rate. Default values depend on Bitrate control mode and Profile.
    bitrate: ?i32,

    /// Specify the AAC profile. For the widest player compatibility and where
    /// higher bitrates are acceptable: Keep the default profile, LC (AAC-LC) For
    /// improved audio performance at lower bitrates: Choose HEV1 or HEV2. HEV1
    /// (AAC-HE v1) adds spectral band replication to improve speech audio at low
    /// bitrates. HEV2 (AAC-HE v2) adds parametric stereo, which optimizes for
    /// encoding stereo audio at very low bitrates. For improved audio quality at
    /// lower bitrates, adaptive audio bitrate switching, and loudness control:
    /// Choose XHE.
    codec_profile: ?AacCodecProfile,

    /// The Coding mode that you specify determines the number of audio channels and
    /// the audio channel layout metadata in your AAC output. Valid coding modes
    /// depend on the Rate control mode and Profile that you select. The following
    /// list shows the number of audio channels and channel layout for each coding
    /// mode. * 1.0 Audio Description (Receiver Mix): One channel, C. Includes audio
    /// description data from your stereo input. For more information see ETSI TS
    /// 101 154 Annex E. * 1.0 Mono: One channel, C. * 2.0 Stereo: Two channels, L,
    /// R. * 5.1 Surround: Six channels, C, L, R, Ls, Rs, LFE. To follow the number
    /// of channels from your input audio, choose CODING_MODE_AUTO, and the service
    /// will automatically choose from one of the coding modes above.
    coding_mode: ?AacCodingMode,

    /// Choose the loudness measurement mode for your audio content. For music or
    /// advertisements: We recommend that you keep the default value, Program. For
    /// speech or other content: We recommend that you choose Anchor. When you do,
    /// MediaConvert optimizes the loudness of your output for clarify by applying
    /// speech gates.
    loudness_measurement_mode: ?AacLoudnessMeasurementMode,

    /// Specify the RAP (Random Access Point) interval for your xHE-AAC audio
    /// output. A RAP allows a decoder to decode audio data mid-stream, without the
    /// need to reference previous audio frames, and perform adaptive audio bitrate
    /// switching. To specify the RAP interval: Enter an integer from 2000 to 30000,
    /// in milliseconds. Smaller values allow for better seeking and more frequent
    /// stream switching, while large values improve compression efficiency. To have
    /// MediaConvert automatically determine the RAP interval: Leave blank.
    rap_interval: ?i32,

    /// Specify the AAC rate control mode. For a constant bitrate: Choose CBR. Your
    /// AAC output bitrate will be equal to the value that you choose for Bitrate.
    /// For a variable bitrate: Choose VBR. Your AAC output bitrate will vary
    /// according to your audio content and the value that you choose for Bitrate
    /// quality.
    rate_control_mode: ?AacRateControlMode,

    /// Enables LATM/LOAS AAC output. Note that if you use LATM/LOAS AAC in an
    /// output, you must choose "No container" for the output container.
    raw_format: ?AacRawFormat,

    /// Specify the AAC sample rate in samples per second (Hz). Valid sample rates
    /// depend on the AAC profile and Coding mode that you select. For a list of
    /// supported sample rates, see:
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/aac-support.html
    sample_rate: ?i32,

    /// Use MPEG-2 AAC instead of MPEG-4 AAC audio for raw or MPEG-2 Transport
    /// Stream containers.
    specification: ?AacSpecification,

    /// Specify the xHE-AAC loudness target. Enter an integer from 6 to 16,
    /// representing "loudness units". For more information, see the following
    /// specification: Supplementary information for R 128 EBU Tech 3342-2023.
    target_loudness_range: ?i32,

    /// Specify the quality of your variable bitrate (VBR) AAC audio. For a list of
    /// approximate VBR bitrates, see:
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/aac-support.html#aac_vbr
    vbr_quality: ?AacVbrQuality,

    pub const json_field_names = .{
        .audio_description_broadcaster_mix = "AudioDescriptionBroadcasterMix",
        .bitrate = "Bitrate",
        .codec_profile = "CodecProfile",
        .coding_mode = "CodingMode",
        .loudness_measurement_mode = "LoudnessMeasurementMode",
        .rap_interval = "RapInterval",
        .rate_control_mode = "RateControlMode",
        .raw_format = "RawFormat",
        .sample_rate = "SampleRate",
        .specification = "Specification",
        .target_loudness_range = "TargetLoudnessRange",
        .vbr_quality = "VbrQuality",
    };
};
