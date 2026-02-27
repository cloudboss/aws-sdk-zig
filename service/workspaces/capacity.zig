/// Describes the user capacity for a pool of WorkSpaces.
pub const Capacity = struct {
    /// The desired number of user sessions for the WorkSpaces in the pool.
    desired_user_sessions: i32,

    pub const json_field_names = .{
        .desired_user_sessions = "DesiredUserSessions",
    };
};
