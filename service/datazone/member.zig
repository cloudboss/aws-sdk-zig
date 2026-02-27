/// The details about a project member.
pub const Member = union(enum) {
    /// The ID of the group of a project member.
    group_identifier: ?[]const u8,
    /// The user ID of a project member.
    user_identifier: ?[]const u8,

    pub const json_field_names = .{
        .group_identifier = "groupIdentifier",
        .user_identifier = "userIdentifier",
    };
};
