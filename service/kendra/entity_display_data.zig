/// Information about the user entity.
pub const EntityDisplayData = struct {
    /// The first name of the user.
    first_name: ?[]const u8,

    /// The name of the group.
    group_name: ?[]const u8,

    /// The user name of the user.
    identified_user_name: ?[]const u8,

    /// The last name of the user.
    last_name: ?[]const u8,

    /// The name of the user.
    user_name: ?[]const u8,

    pub const json_field_names = .{
        .first_name = "FirstName",
        .group_name = "GroupName",
        .identified_user_name = "IdentifiedUserName",
        .last_name = "LastName",
        .user_name = "UserName",
    };
};
