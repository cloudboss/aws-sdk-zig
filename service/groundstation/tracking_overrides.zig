const ProgramTrackSettings = @import("program_track_settings.zig").ProgramTrackSettings;

/// Overrides the default tracking configuration on an antenna during a contact.
pub const TrackingOverrides = struct {
    /// Program track settings to override for antenna tracking during the contact.
    program_track_settings: ProgramTrackSettings,

    pub const json_field_names = .{
        .program_track_settings = "programTrackSettings",
    };
};
