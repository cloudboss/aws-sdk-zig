/// Identifies an existing data transformation profile and version to clone when
/// creating a new profile.
pub const ExistingVersionedProfileSource = struct {
    /// The unique identifier of the existing profile to clone from.
    profile_id: []const u8,

    /// The version number of the existing profile to clone from.
    version: i32,

    pub const json_field_names = .{
        .profile_id = "ProfileId",
        .version = "Version",
    };
};
