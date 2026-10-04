/// The profile configuration for a data store.
pub const ProfileConfiguration = struct {
    /// The list of default profiles for the data store.
    default_profiles: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .default_profiles = "DefaultProfiles",
    };
};
