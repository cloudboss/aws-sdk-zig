/// Identifies a built-in starter profile to use as the source when creating a
/// data transformation profile. Valid only when the source format is
/// Consolidated Clinical Document Architecture (C-CDA).
pub const StarterProfileSource = struct {
    /// The name of the built-in starter profile.
    starter_profile_name: []const u8,

    pub const json_field_names = .{
        .starter_profile_name = "StarterProfileName",
    };
};
