/// Describes a request to enable or modify the automatic snapshot add-on for an
/// Amazon Lightsail instance or disk.
///
/// When you modify the automatic snapshot time for a resource, it is typically
/// effective
/// immediately except under the following conditions:
///
/// * If an automatic snapshot has been created for the current day, and you
///   change the
/// snapshot time to a later time of day, then the new snapshot time will be
/// effective the
/// following day. This ensures that two snapshots are not created for the
/// current day.
///
/// * If an automatic snapshot has not yet been created for the current day, and
///   you change
/// the snapshot time to an earlier time of day, then the new snapshot time will
/// be effective
/// the following day and a snapshot is automatically created at the previously
/// set time for
/// the current day. This ensures that a snapshot is created for the current
/// day.
///
/// * If an automatic snapshot has not yet been created for the current day, and
///   you change
/// the snapshot time to a time that is within 30 minutes from your current
/// time, then the new
/// snapshot time will be effective the following day and a snapshot is
/// automatically created
/// at the previously set time for the current day. This ensures that a snapshot
/// is created
/// for the current day, because 30 minutes is required between your current
/// time and the new
/// snapshot time that you specify.
///
/// * If an automatic snapshot is scheduled to be created within 30 minutes from
///   your
/// current time and you change the snapshot time, then the new snapshot time
/// will be
/// effective the following day and a snapshot is automatically created at the
/// previously set
/// time for the current day. This ensures that a snapshot is created for the
/// current day,
/// because 30 minutes is required between your current time and the new
/// snapshot time that
/// you specify.
pub const AutoSnapshotAddOnRequest = struct {
    /// The daily time when an automatic snapshot will be created.
    ///
    /// Constraints:
    ///
    /// * Must be in `HH:00` format, and in an hourly increment.
    ///
    /// * Specified in Coordinated Universal Time (UTC).
    ///
    /// * The snapshot will be automatically created between the time specified and
    ///   up to 45
    /// minutes after.
    snapshot_time_of_day: ?[]const u8,

    pub const json_field_names = .{
        .snapshot_time_of_day = "snapshotTimeOfDay",
    };
};
