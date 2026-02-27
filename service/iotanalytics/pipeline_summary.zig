const ReprocessingSummary = @import("reprocessing_summary.zig").ReprocessingSummary;

/// A summary of information about a pipeline.
pub const PipelineSummary = struct {
    /// When the pipeline was created.
    creation_time: ?i64,

    /// When the pipeline was last updated.
    last_update_time: ?i64,

    /// The name of the pipeline.
    pipeline_name: ?[]const u8,

    /// A summary of information about the pipeline reprocessing.
    reprocessing_summaries: ?[]const ReprocessingSummary,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .last_update_time = "lastUpdateTime",
        .pipeline_name = "pipelineName",
        .reprocessing_summaries = "reprocessingSummaries",
    };
};
