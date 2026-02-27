const AzElProgramTrackSettings = @import("az_el_program_track_settings.zig").AzElProgramTrackSettings;

/// Program track settings for an antenna during a contact.
pub const ProgramTrackSettings = union(enum) {
    /// Program track settings for AzElEphemeris.
    az_el: ?AzElProgramTrackSettings,

    pub const json_field_names = .{
        .az_el = "azEl",
    };
};
