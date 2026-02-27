/// Specifies summary information about the ownership settings.
pub const OwnershipSettingsSummary = struct {
    /// The user profile who is the owner of the space.
    owner_user_profile_name: ?[]const u8,

    pub const json_field_names = .{
        .owner_user_profile_name = "OwnerUserProfileName",
    };
};
