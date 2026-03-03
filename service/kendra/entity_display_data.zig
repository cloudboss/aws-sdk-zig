/// Information about the user entity.
pub const EntityDisplayData = struct {
    /// The first name of the user.
    first_name: ?[]const u8 = null,

    /// The name of the group.
    group_name: ?[]const u8 = null,

    /// The user name of the user.
    identified_user_name: ?[]const u8 = null,

    /// The last name of the user.
    last_name: ?[]const u8 = null,

    /// The name of the user.
    user_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .first_name = "FirstName",
        .group_name = "GroupName",
        .identified_user_name = "IdentifiedUserName",
        .last_name = "LastName",
        .user_name = "UserName",
    };
};
