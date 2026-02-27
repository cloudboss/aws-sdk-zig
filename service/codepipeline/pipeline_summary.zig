const ExecutionMode = @import("execution_mode.zig").ExecutionMode;
const PipelineType = @import("pipeline_type.zig").PipelineType;

/// Returns a summary of a pipeline.
pub const PipelineSummary = struct {
    /// The date and time the pipeline was created, in timestamp format.
    created: ?i64,

    /// The method that the pipeline will use to handle multiple executions. The
    /// default
    /// mode is SUPERSEDED.
    execution_mode: ?ExecutionMode,

    /// The name of the pipeline.
    name: ?[]const u8,

    /// CodePipeline provides the following pipeline types, which differ in
    /// characteristics and price, so that you can tailor your pipeline features and
    /// cost to the
    /// needs of your applications.
    ///
    /// * V1 type pipelines have a JSON structure that contains standard pipeline,
    /// stage, and action-level parameters.
    ///
    /// * V2 type pipelines have the same structure as a V1 type, along with
    ///   additional
    /// parameters for release safety and trigger configuration.
    ///
    /// Including V2 parameters, such as triggers on Git tags, in the pipeline JSON
    /// when
    /// creating or updating a pipeline will result in the pipeline having the V2
    /// type of
    /// pipeline and the associated costs.
    ///
    /// For information about pricing for CodePipeline, see
    /// [Pricing](http://aws.amazon.com/codepipeline/pricing/).
    ///
    /// For information about which type of pipeline to choose, see [What type of
    /// pipeline is right for
    /// me?](https://docs.aws.amazon.com/codepipeline/latest/userguide/pipeline-types-planning.html).
    pipeline_type: ?PipelineType,

    /// The date and time of the last update to the pipeline, in timestamp
    /// format.
    updated: ?i64,

    /// The version number of the pipeline.
    version: ?i32,

    pub const json_field_names = .{
        .created = "created",
        .execution_mode = "executionMode",
        .name = "name",
        .pipeline_type = "pipelineType",
        .updated = "updated",
        .version = "version",
    };
};
