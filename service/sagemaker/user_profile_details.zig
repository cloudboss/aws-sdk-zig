const UserProfileStatus = @import("user_profile_status.zig").UserProfileStatus;

/// The user profile details.
pub const UserProfileDetails = struct {
    /// The creation time.
    creation_time: ?i64 = null,

    /// The domain ID.
    domain_id: ?[]const u8 = null,

    /// The last modified time.
    last_modified_time: ?i64 = null,

    /// The status.
    status: ?UserProfileStatus = null,

    /// The user profile name.
    user_profile_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .domain_id = "DomainId",
        .last_modified_time = "LastModifiedTime",
        .status = "Status",
        .user_profile_name = "UserProfileName",
    };
};
