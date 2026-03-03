/// The configuration for an application to automatically stop after a certain
/// amount of time being idle.
pub const AutoStopConfig = struct {
    /// Enables the application to automatically stop after a certain amount of time
    /// being idle. Defaults to true.
    enabled: ?bool = null,

    /// The amount of idle time in minutes after which your application will
    /// automatically stop. Defaults to 15 minutes.
    idle_timeout_minutes: ?i32 = null,

    pub const json_field_names = .{
        .enabled = "enabled",
        .idle_timeout_minutes = "idleTimeoutMinutes",
    };
};
