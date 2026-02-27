/// Export task summary.
pub const ExportTaskSummary = struct {
    /// Export task summary applications count.
    applications_count: i64 = 0,

    /// Export task summary servers count.
    servers_count: i64 = 0,

    /// Export task summary waves count.
    waves_count: i64 = 0,

    pub const json_field_names = .{
        .applications_count = "applicationsCount",
        .servers_count = "serversCount",
        .waves_count = "wavesCount",
    };
};
