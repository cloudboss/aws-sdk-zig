/// Specifies one range of days or times to exclude from use for training an
/// anomaly
/// detection model.
pub const Range = struct {
    /// The end time of the range to exclude. The format is
    /// `yyyy-MM-dd'T'HH:mm:ss`. For example,
    /// `2019-07-01T23:59:59`.
    end_time: i64,

    /// The start time of the range to exclude. The format is
    /// `yyyy-MM-dd'T'HH:mm:ss`. For example,
    /// `2019-07-01T23:59:59`.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
