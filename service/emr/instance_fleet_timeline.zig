/// Provides historical timestamps for the instance fleet, including the time of
/// creation,
/// the time it became ready to run jobs, and the time of termination.
///
/// The instance fleet configuration is available only in Amazon EMR releases
/// 4.8.0 and later, excluding 5.0.x versions.
pub const InstanceFleetTimeline = struct {
    /// The time and date the instance fleet was created.
    creation_date_time: ?i64 = null,

    /// The time and date the instance fleet terminated.
    end_date_time: ?i64 = null,

    /// The time and date the instance fleet was ready to run jobs.
    ready_date_time: ?i64 = null,

    pub const json_field_names = .{
        .creation_date_time = "CreationDateTime",
        .end_date_time = "EndDateTime",
        .ready_date_time = "ReadyDateTime",
    };
};
