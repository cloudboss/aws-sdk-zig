const aws = @import("aws");

/// An object that represents the array properties of a job.
pub const ArrayPropertiesSummary = struct {
    /// The job index within the array that's associated with this job. This
    /// parameter is returned
    /// for children of array jobs.
    index: ?i32,

    /// The size of the array job. This parameter is returned for parent array jobs.
    size: ?i32,

    /// A summary of the number of array job children in each available job status.
    /// This parameter
    /// is returned for parent array jobs.
    status_summary: ?[]const aws.map.MapEntry(i32),

    /// The Unix timestamp (in milliseconds) for when the `statusSummary` was last
    /// updated.
    status_summary_last_updated_at: ?i64,

    pub const json_field_names = .{
        .index = "index",
        .size = "size",
        .status_summary = "statusSummary",
        .status_summary_last_updated_at = "statusSummaryLastUpdatedAt",
    };
};
