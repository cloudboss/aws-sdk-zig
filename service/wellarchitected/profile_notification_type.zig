pub const ProfileNotificationType = enum {
    profile_answers_updated,
    profile_deleted,

    pub const json_field_names = .{
        .profile_answers_updated = "PROFILE_ANSWERS_UPDATED",
        .profile_deleted = "PROFILE_DELETED",
    };
};
