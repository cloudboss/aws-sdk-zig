/// The user details of a project member.
pub const UserDetails = struct {
    /// The identifier of the Amazon DataZone user.
    user_id: []const u8,

    pub const json_field_names = .{
        .user_id = "userId",
    };
};
