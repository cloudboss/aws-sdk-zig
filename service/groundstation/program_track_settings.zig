const AzElProgramTrackSettings = @import("az_el_program_track_settings.zig").AzElProgramTrackSettings;
const OemProgramTrackSettings = @import("oem_program_track_settings.zig").OemProgramTrackSettings;
const TleProgramTrackSettings = @import("tle_program_track_settings.zig").TleProgramTrackSettings;

/// Program track settings for an antenna during a contact.
pub const ProgramTrackSettings = union(enum) {
    /// Program track settings for AzElEphemeris.
    az_el: ?AzElProgramTrackSettings,
    /// Program track settings for OEMEphemeris.
    oem: ?OemProgramTrackSettings,
    /// Program track settings for TLEEphemeris.
    tle: ?TleProgramTrackSettings,

    pub const json_field_names = .{
        .az_el = "azEl",
        .oem = "oem",
        .tle = "tle",
    };
};
