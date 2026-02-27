/// The summary of the media pipeline.
pub const MediaPipelineSummary = struct {
    /// The ARN of the media pipeline in the summary.
    media_pipeline_arn: ?[]const u8,

    /// The ID of the media pipeline in the summary.
    media_pipeline_id: ?[]const u8,

    pub const json_field_names = .{
        .media_pipeline_arn = "MediaPipelineArn",
        .media_pipeline_id = "MediaPipelineId",
    };
};
