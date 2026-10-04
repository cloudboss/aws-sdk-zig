/// Contains information about the time range within the continuous backup in
/// Amazon Web Services Backup to scan for a point-in-time recovery resource.
pub const ContinuousScanDetails = struct {
    /// The timestamp representing the end of the time range to scan.
    end_time: i64,

    /// The timestamp representing the start of the time range to scan. Reserved for
    /// internal use.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
