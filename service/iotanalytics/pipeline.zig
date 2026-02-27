const PipelineActivity = @import("pipeline_activity.zig").PipelineActivity;
const ReprocessingSummary = @import("reprocessing_summary.zig").ReprocessingSummary;

/// Contains information about a pipeline.
pub const Pipeline = struct {
    /// The activities that perform transformations on the messages.
    activities: ?[]const PipelineActivity,

    /// The ARN of the pipeline.
    arn: ?[]const u8,

    /// When the pipeline was created.
    creation_time: ?i64,

    /// The last time the pipeline was updated.
    last_update_time: ?i64,

    /// The name of the pipeline.
    name: ?[]const u8,

    /// A summary of information about the pipeline reprocessing.
    reprocessing_summaries: ?[]const ReprocessingSummary,

    pub const json_field_names = .{
        .activities = "activities",
        .arn = "arn",
        .creation_time = "creationTime",
        .last_update_time = "lastUpdateTime",
        .name = "name",
        .reprocessing_summaries = "reprocessingSummaries",
    };
};
