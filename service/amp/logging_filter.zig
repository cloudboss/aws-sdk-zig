/// Filtering criteria that determine which queries are logged.
pub const LoggingFilter = struct {
    /// The Query Samples Processed (QSP) threshold above which queries will be
    /// logged. Queries processing more samples than this threshold will be captured
    /// in logs.
    qsp_threshold: i64,

    pub const json_field_names = .{
        .qsp_threshold = "qspThreshold",
    };
};
