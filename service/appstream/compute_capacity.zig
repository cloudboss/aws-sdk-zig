/// Describes the capacity for a fleet.
pub const ComputeCapacity = struct {
    /// The desired number of streaming instances.
    desired_instances: ?i32,

    /// The desired number of user sessions for a multi-session fleet. This is not
    /// allowed for single-session fleets.
    ///
    /// When you create a fleet, you must set either the DesiredSessions or
    /// DesiredInstances attribute, based on the type of fleet you create. You can’t
    /// define both attributes or leave both attributes blank.
    desired_sessions: ?i32,

    pub const json_field_names = .{
        .desired_instances = "DesiredInstances",
        .desired_sessions = "DesiredSessions",
    };
};
