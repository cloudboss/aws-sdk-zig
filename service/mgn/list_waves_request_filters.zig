/// Waves list filters.
pub const ListWavesRequestFilters = struct {
    /// Filter waves list by archival status.
    is_archived: ?bool,

    /// Filter waves list by wave ID.
    wave_i_ds: ?[]const []const u8,

    pub const json_field_names = .{
        .is_archived = "isArchived",
        .wave_i_ds = "waveIDs",
    };
};
