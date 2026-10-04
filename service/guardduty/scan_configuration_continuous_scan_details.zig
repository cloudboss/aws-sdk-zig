/// Contains information about the time range within the continuous backup in
/// Amazon Web Services Backup that was scanned for a point-in-time recovery
/// resource.
pub const ScanConfigurationContinuousScanDetails = struct {
    /// The timestamp representing the end of the time range that was scanned.
    end_time: i64,

    /// The timestamp representing the start of the time range that was scanned.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
