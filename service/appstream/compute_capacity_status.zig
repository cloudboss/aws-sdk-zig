/// Describes the capacity status for a fleet.
pub const ComputeCapacityStatus = struct {
    /// The number of user sessions currently being used for streaming sessions.
    /// This only applies to multi-session fleets.
    active_user_sessions: ?i32,

    /// The total number of session slots that are available for streaming or are
    /// currently streaming.
    ///
    /// ActualUserSessionCapacity = AvailableUserSessionCapacity +
    /// ActiveUserSessions
    ///
    /// This only applies to multi-session fleets.
    actual_user_sessions: ?i32,

    /// The number of currently available instances that can be used to stream
    /// sessions.
    available: ?i32,

    /// The number of idle session slots currently available for user sessions.
    ///
    /// AvailableUserSessionCapacity = ActualUserSessionCapacity -
    /// ActiveUserSessions
    ///
    /// This only applies to multi-session fleets.
    available_user_sessions: ?i32,

    /// The desired number of streaming instances.
    desired: i32,

    /// The total number of sessions slots that are either running or pending. This
    /// represents the total number of concurrent streaming sessions your fleet can
    /// support in a steady state.
    ///
    /// DesiredUserSessionCapacity = ActualUserSessionCapacity +
    /// PendingUserSessionCapacity
    ///
    /// This only applies to multi-session fleets.
    desired_user_sessions: ?i32,

    /// The number of instances in use for streaming.
    in_use: ?i32,

    /// The total number of simultaneous streaming instances that are running.
    running: ?i32,

    pub const json_field_names = .{
        .active_user_sessions = "ActiveUserSessions",
        .actual_user_sessions = "ActualUserSessions",
        .available = "Available",
        .available_user_sessions = "AvailableUserSessions",
        .desired = "Desired",
        .desired_user_sessions = "DesiredUserSessions",
        .in_use = "InUse",
        .running = "Running",
    };
};
