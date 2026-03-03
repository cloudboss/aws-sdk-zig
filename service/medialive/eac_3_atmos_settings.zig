const Eac3AtmosCodingMode = @import("eac_3_atmos_coding_mode.zig").Eac3AtmosCodingMode;
const Eac3AtmosDrcLine = @import("eac_3_atmos_drc_line.zig").Eac3AtmosDrcLine;
const Eac3AtmosDrcRf = @import("eac_3_atmos_drc_rf.zig").Eac3AtmosDrcRf;

/// Eac3 Atmos Settings
pub const Eac3AtmosSettings = struct {
    /// Average bitrate in bits/second. Valid bitrates depend on the coding mode.
    bitrate: ?f64 = null,

    /// Dolby Digital Plus with Dolby Atmos coding mode. Determines number of
    /// channels.
    coding_mode: ?Eac3AtmosCodingMode = null,

    /// Sets the dialnorm for the output. Default 23.
    dialnorm: ?i32 = null,

    /// Sets the Dolby dynamic range compression profile.
    drc_line: ?Eac3AtmosDrcLine = null,

    /// Sets the profile for heavy Dolby dynamic range compression, ensures that the
    /// instantaneous signal peaks do not exceed specified levels.
    drc_rf: ?Eac3AtmosDrcRf = null,

    /// Height dimensional trim. Sets the maximum amount to attenuate the height
    /// channels when the downstream player isn??t configured to handle Dolby
    /// Digital Plus with Dolby Atmos and must remix the channels.
    height_trim: ?f64 = null,

    /// Surround dimensional trim. Sets the maximum amount to attenuate the surround
    /// channels when the downstream player isn't configured to handle Dolby Digital
    /// Plus with Dolby Atmos and must remix the channels.
    surround_trim: ?f64 = null,

    pub const json_field_names = .{
        .bitrate = "Bitrate",
        .coding_mode = "CodingMode",
        .dialnorm = "Dialnorm",
        .drc_line = "DrcLine",
        .drc_rf = "DrcRf",
        .height_trim = "HeightTrim",
        .surround_trim = "SurroundTrim",
    };
};
