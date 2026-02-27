const IngestionType = @import("ingestion_type.zig").IngestionType;
const RefreshFrequency = @import("refresh_frequency.zig").RefreshFrequency;

/// The refresh schedule of a dataset.
pub const RefreshSchedule = struct {
    /// The Amazon Resource Name (ARN) for the refresh schedule.
    arn: ?[]const u8,

    /// The type of refresh that a datset undergoes. Valid values are as follows:
    ///
    /// * `FULL_REFRESH`: A complete refresh of a dataset.
    ///
    /// * `INCREMENTAL_REFRESH`: A partial refresh of some rows of a dataset, based
    ///   on the time window specified.
    ///
    /// For more information on full and incremental refreshes, see [Refreshing
    /// SPICE
    /// data](https://docs.aws.amazon.com/quicksight/latest/user/refreshing-imported-data.html) in the *Amazon Quick Suite User Guide*.
    refresh_type: IngestionType,

    /// The frequency for the refresh schedule.
    schedule_frequency: RefreshFrequency,

    /// An identifier for the refresh schedule.
    schedule_id: []const u8,

    /// Time after which the refresh schedule can be started, expressed in
    /// `YYYY-MM-DDTHH:MM:SS` format.
    start_after_date_time: ?i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .refresh_type = "RefreshType",
        .schedule_frequency = "ScheduleFrequency",
        .schedule_id = "ScheduleId",
        .start_after_date_time = "StartAfterDateTime",
    };
};
