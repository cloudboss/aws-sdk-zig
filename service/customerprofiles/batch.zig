/// Batch defines the boundaries for ingestion for each step in
/// `APPFLOW_INTEGRATION` workflow. `APPFLOW_INTEGRATION` workflow
/// splits ingestion based on these boundaries.
pub const Batch = struct {
    /// End time of batch to split ingestion.
    end_time: i64,

    /// Start time of batch to split ingestion.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
