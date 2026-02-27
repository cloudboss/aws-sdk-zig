/// Information about a pipeline.
pub const PipelineMetadata = struct {
    /// The date and time the pipeline was created, in timestamp format.
    created: ?i64,

    /// The Amazon Resource Name (ARN) of the pipeline.
    pipeline_arn: ?[]const u8,

    /// The date and time that polling for source changes (periodic checks) was
    /// stopped for
    /// the pipeline, in timestamp format.
    ///
    /// Pipelines that are inactive for longer than 30 days will have polling
    /// disabled for
    /// the pipeline. For more information, see
    /// [pollingDisabledAt](https://docs.aws.amazon.com/codepipeline/latest/userguide/reference-pipeline-structure.html#metadata.pollingDisabledAt) in the pipeline structure reference. For the steps to
    /// migrate your pipeline from polling to event-based change detection, see
    /// [Migrate polling
    /// pipelines to use event-based change
    /// detection](https://docs.aws.amazon.com/codepipeline/latest/userguide/update-change-detection.html).
    ///
    /// You can migrate (update) a polling pipeline to use event-based change
    /// detection. For
    /// example, for a pipeline with a CodeCommit source, we recommend you migrate
    /// (update) your pipeline to use CloudWatch Events. To learn more, see [Migrate
    /// polling
    /// pipelines to use event-based change
    /// detection](https://docs.aws.amazon.com/codepipeline/latest/userguide/update-change-detection.html) in the *CodePipeline User Guide*.
    polling_disabled_at: ?i64,

    /// The date and time the pipeline was last updated, in timestamp format.
    updated: ?i64,

    pub const json_field_names = .{
        .created = "created",
        .pipeline_arn = "pipelineArn",
        .polling_disabled_at = "pollingDisabledAt",
        .updated = "updated",
    };
};
