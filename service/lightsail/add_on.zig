/// Describes an add-on that is enabled for an Amazon Lightsail resource.
pub const AddOn = struct {
    /// The amount of idle time in minutes after which your virtual computer will
    /// automatically
    /// stop.
    ///
    /// This add-on only applies to Lightsail for Research resources.
    duration: ?[]const u8,

    /// The name of the add-on.
    name: ?[]const u8,

    /// The next daily time an automatic snapshot will be created.
    ///
    /// The time shown is in `HH:00` format, and in Coordinated Universal Time
    /// (UTC).
    ///
    /// The snapshot is automatically created between the time shown and up to 45
    /// minutes
    /// after.
    next_snapshot_time_of_day: ?[]const u8,

    /// The daily time when an automatic snapshot is created.
    ///
    /// The time shown is in `HH:00` format, and in Coordinated Universal Time
    /// (UTC).
    ///
    /// The snapshot is automatically created between the time shown and up to 45
    /// minutes
    /// after.
    snapshot_time_of_day: ?[]const u8,

    /// The status of the add-on.
    status: ?[]const u8,

    /// The trigger threshold of the action.
    ///
    /// This add-on only applies to Lightsail for Research resources.
    threshold: ?[]const u8,

    pub const json_field_names = .{
        .duration = "duration",
        .name = "name",
        .next_snapshot_time_of_day = "nextSnapshotTimeOfDay",
        .snapshot_time_of_day = "snapshotTimeOfDay",
        .status = "status",
        .threshold = "threshold",
    };
};
