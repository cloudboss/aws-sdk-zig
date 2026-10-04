/// Information about a database management tool for an Autonomous Database.
pub const DatabaseTool = struct {
    /// The compute capacity allocated to the database management tool.
    compute_count: ?f64 = null,

    /// Indicates whether the database management tool is enabled.
    is_enabled: ?bool = null,

    /// The maximum amount of time, in minutes, that the database management tool
    /// can be idle before it is shut down.
    max_idle_time_in_minutes: ?i32 = null,

    /// The name of the database management tool.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .compute_count = "computeCount",
        .is_enabled = "isEnabled",
        .max_idle_time_in_minutes = "maxIdleTimeInMinutes",
        .name = "name",
    };
};
