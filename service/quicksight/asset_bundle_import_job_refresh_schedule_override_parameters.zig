/// A list of overrides for a specific `RefreshsSchedule` resource that is
/// present in the asset bundle that is imported.
pub const AssetBundleImportJobRefreshScheduleOverrideParameters = struct {
    /// A partial identifier for the specific `RefreshSchedule` resource that is
    /// being overridden. This structure is used together with the `ScheduleID`
    /// structure.
    data_set_id: []const u8,

    /// A partial identifier for the specific `RefreshSchedule` resource being
    /// overridden. This structure is used together with the `DataSetId`
    /// structure.
    schedule_id: []const u8,

    /// An override for the `StartAfterDateTime` of a `RefreshSchedule`.
    /// Make sure that the `StartAfterDateTime` is set to a time that takes place in
    /// the
    /// future.
    start_after_date_time: ?i64 = null,

    pub const json_field_names = .{
        .data_set_id = "DataSetId",
        .schedule_id = "ScheduleId",
        .start_after_date_time = "StartAfterDateTime",
    };
};
