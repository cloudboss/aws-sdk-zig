/// Describes the capacity status for a pool of WorkSpaces.
pub const CapacityStatus = struct {
    /// The number of user sessions currently being used for your pool.
    active_user_sessions: i32,

    /// The total number of user sessions that are available for streaming or are
    /// currently
    /// streaming in your pool.
    ///
    /// ActualUserSessions = AvailableUserSessions + ActiveUserSessions
    actual_user_sessions: i32,

    /// The number of user sessions currently available for streaming from your
    /// pool.
    ///
    /// AvailableUserSessions = ActualUserSessions - ActiveUserSessions
    available_user_sessions: i32,

    /// The total number of sessions slots that are either running or pending. This
    /// represents the total number of concurrent streaming sessions your pool can
    /// support
    /// in a steady state.
    desired_user_sessions: i32,

    pub const json_field_names = .{
        .active_user_sessions = "ActiveUserSessions",
        .actual_user_sessions = "ActualUserSessions",
        .available_user_sessions = "AvailableUserSessions",
        .desired_user_sessions = "DesiredUserSessions",
    };
};
