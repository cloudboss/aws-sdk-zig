/// Defines the traffic pattern.
pub const Phase = struct {
    /// Specifies how long a traffic phase should be. For custom load tests, the
    /// value should be between 120 and 3600. This value should not exceed
    /// `JobDurationInSeconds`.
    duration_in_seconds: ?i32 = null,

    /// Specifies how many concurrent users to start with. The value should be
    /// between 1 and 3.
    initial_number_of_users: ?i32 = null,

    /// Specified how many new users to spawn in a minute.
    spawn_rate: ?i32 = null,

    pub const json_field_names = .{
        .duration_in_seconds = "DurationInSeconds",
        .initial_number_of_users = "InitialNumberOfUsers",
        .spawn_rate = "SpawnRate",
    };
};
