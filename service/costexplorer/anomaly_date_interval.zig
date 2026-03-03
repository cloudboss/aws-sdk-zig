/// The time period for an anomaly.
pub const AnomalyDateInterval = struct {
    /// The last date an anomaly was observed.
    end_date: ?[]const u8 = null,

    /// The first date an anomaly was observed.
    start_date: []const u8,

    pub const json_field_names = .{
        .end_date = "EndDate",
        .start_date = "StartDate",
    };
};
