const AacCodingMode = @import("aac_coding_mode.zig").AacCodingMode;
const AacInputType = @import("aac_input_type.zig").AacInputType;
const AacProfile = @import("aac_profile.zig").AacProfile;
const AacRateControlMode = @import("aac_rate_control_mode.zig").AacRateControlMode;
const AacRawFormat = @import("aac_raw_format.zig").AacRawFormat;
const AacSpec = @import("aac_spec.zig").AacSpec;
const AacVbrQuality = @import("aac_vbr_quality.zig").AacVbrQuality;

/// Aac Settings
pub const AacSettings = struct {
    /// Average bitrate in bits/second. Valid values depend on rate control mode and
    /// profile.
    bitrate: ?f64 = null,

    /// Mono, Stereo, or 5.1 channel layout. Valid values depend on rate control
    /// mode and profile. The adReceiverMix setting receives a stereo description
    /// plus control track and emits a mono AAC encode of the description track,
    /// with control data emitted in the PES header as per ETSI TS 101 154 Annex E.
    coding_mode: ?AacCodingMode = null,

    /// Set to "broadcasterMixedAd" when input contains pre-mixed main audio + AD
    /// (narration) as a stereo pair. The Audio Type field (audioType) will be set
    /// to 3, which signals to downstream systems that this stream contains
    /// "broadcaster mixed AD". Note that the input received by the encoder must
    /// contain pre-mixed audio; the encoder does not perform the mixing. The values
    /// in audioTypeControl and audioType (in AudioDescription) are ignored when set
    /// to broadcasterMixedAd.
    ///
    /// Leave set to "normal" when input does not contain pre-mixed audio + AD.
    input_type: ?AacInputType = null,

    /// AAC Profile.
    profile: ?AacProfile = null,

    /// Rate Control Mode.
    rate_control_mode: ?AacRateControlMode = null,

    /// Sets LATM / LOAS AAC output for raw containers.
    raw_format: ?AacRawFormat = null,

    /// Sample rate in Hz. Valid values depend on rate control mode and profile.
    sample_rate: ?f64 = null,

    /// Use MPEG-2 AAC audio instead of MPEG-4 AAC audio for raw or MPEG-2 Transport
    /// Stream containers.
    spec: ?AacSpec = null,

    /// VBR Quality Level - Only used if rateControlMode is VBR.
    vbr_quality: ?AacVbrQuality = null,

    pub const json_field_names = .{
        .bitrate = "Bitrate",
        .coding_mode = "CodingMode",
        .input_type = "InputType",
        .profile = "Profile",
        .rate_control_mode = "RateControlMode",
        .raw_format = "RawFormat",
        .sample_rate = "SampleRate",
        .spec = "Spec",
        .vbr_quality = "VbrQuality",
    };
};
