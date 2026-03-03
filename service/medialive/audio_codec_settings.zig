const AacSettings = @import("aac_settings.zig").AacSettings;
const Ac3Settings = @import("ac_3_settings.zig").Ac3Settings;
const Eac3AtmosSettings = @import("eac_3_atmos_settings.zig").Eac3AtmosSettings;
const Eac3Settings = @import("eac_3_settings.zig").Eac3Settings;
const Mp2Settings = @import("mp_2_settings.zig").Mp2Settings;
const PassThroughSettings = @import("pass_through_settings.zig").PassThroughSettings;
const WavSettings = @import("wav_settings.zig").WavSettings;

/// Audio Codec Settings
pub const AudioCodecSettings = struct {
    aac_settings: ?AacSettings = null,

    ac_3_settings: ?Ac3Settings = null,

    eac_3_atmos_settings: ?Eac3AtmosSettings = null,

    eac_3_settings: ?Eac3Settings = null,

    mp_2_settings: ?Mp2Settings = null,

    pass_through_settings: ?PassThroughSettings = null,

    wav_settings: ?WavSettings = null,

    pub const json_field_names = .{
        .aac_settings = "AacSettings",
        .ac_3_settings = "Ac3Settings",
        .eac_3_atmos_settings = "Eac3AtmosSettings",
        .eac_3_settings = "Eac3Settings",
        .mp_2_settings = "Mp2Settings",
        .pass_through_settings = "PassThroughSettings",
        .wav_settings = "WavSettings",
    };
};
