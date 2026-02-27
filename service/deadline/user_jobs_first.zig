/// Allows setting a specific user's job to run first.
pub const UserJobsFirst = struct {
    /// The user's ID.
    user_identity_id: []const u8,

    pub const json_field_names = .{
        .user_identity_id = "userIdentityId",
    };
};
