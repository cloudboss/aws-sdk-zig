/// Applications list filters.
pub const ListApplicationsRequestFilters = struct {
    /// Filter applications list by application ID.
    application_i_ds: ?[]const []const u8 = null,

    /// Filter applications list by archival status.
    is_archived: ?bool = null,

    /// Filter applications list by wave ID.
    wave_i_ds: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .application_i_ds = "applicationIDs",
        .is_archived = "isArchived",
        .wave_i_ds = "waveIDs",
    };
};
