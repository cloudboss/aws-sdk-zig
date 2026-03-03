const Logging = @import("logging.zig").Logging;

/// Contains the details for a profile. A profile is the mechanism used to
/// create the concept of a private network.
pub const ProfileSummary = struct {
    /// Returns the name for the business associated with this profile.
    business_name: []const u8,

    /// Returns the timestamp for creation date and time of the profile.
    created_at: i64,

    /// Specifies whether or not logging is enabled for this profile.
    logging: ?Logging = null,

    /// Returns the name of the logging group.
    log_group_name: ?[]const u8 = null,

    /// Returns the timestamp that identifies the most recent date and time that the
    /// profile was modified.
    modified_at: ?i64 = null,

    /// Returns the display name for profile.
    name: []const u8,

    /// Returns the unique, system-generated identifier for the profile.
    profile_id: []const u8,

    pub const json_field_names = .{
        .business_name = "businessName",
        .created_at = "createdAt",
        .logging = "logging",
        .log_group_name = "logGroupName",
        .modified_at = "modifiedAt",
        .name = "name",
        .profile_id = "profileId",
    };
};
