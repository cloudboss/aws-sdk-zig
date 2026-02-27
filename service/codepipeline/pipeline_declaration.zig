const aws = @import("aws");

const ArtifactStore = @import("artifact_store.zig").ArtifactStore;
const ExecutionMode = @import("execution_mode.zig").ExecutionMode;
const PipelineType = @import("pipeline_type.zig").PipelineType;
const StageDeclaration = @import("stage_declaration.zig").StageDeclaration;
const PipelineTriggerDeclaration = @import("pipeline_trigger_declaration.zig").PipelineTriggerDeclaration;
const PipelineVariableDeclaration = @import("pipeline_variable_declaration.zig").PipelineVariableDeclaration;

/// Represents the structure of actions and stages to be performed in the
/// pipeline.
pub const PipelineDeclaration = struct {
    /// Represents information about the S3 bucket where artifacts are stored for
    /// the
    /// pipeline.
    ///
    /// You must include either `artifactStore` or
    /// `artifactStores` in your pipeline, but you cannot use both. If you
    /// create a cross-region action in your pipeline, you must use
    /// `artifactStores`.
    artifact_store: ?ArtifactStore,

    /// A mapping of `artifactStore` objects and their corresponding Amazon Web
    /// Services Regions. There must be an artifact store for the pipeline Region
    /// and for
    /// each cross-region action in the pipeline.
    ///
    /// You must include either `artifactStore` or
    /// `artifactStores` in your pipeline, but you cannot use both. If you
    /// create a cross-region action in your pipeline, you must use
    /// `artifactStores`.
    artifact_stores: ?[]const aws.map.MapEntry(ArtifactStore),

    /// The method that the pipeline will use to handle multiple executions. The
    /// default
    /// mode is SUPERSEDED.
    execution_mode: ?ExecutionMode,

    /// The name of the pipeline.
    name: []const u8,

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

    /// The Amazon Resource Name (ARN) for CodePipeline to use to either perform
    /// actions with no `actionRoleArn`, or to use to assume roles for actions with
    /// an `actionRoleArn`.
    role_arn: []const u8,

    /// The stage in which to perform the action.
    stages: []const StageDeclaration,

    /// The trigger configuration specifying a type of event, such as Git tags, that
    /// starts
    /// the pipeline.
    ///
    /// When a trigger configuration is specified, default change detection for
    /// repository and branch commits is disabled.
    triggers: ?[]const PipelineTriggerDeclaration,

    /// A list that defines the pipeline variables for a pipeline resource. Variable
    /// names can
    /// have alphanumeric and underscore characters, and the values must match
    /// `[A-Za-z0-9@\-_]+`.
    variables: ?[]const PipelineVariableDeclaration,

    /// The version number of the pipeline. A new pipeline always has a version
    /// number of
    /// 1. This number is incremented when a pipeline is updated.
    version: ?i32,

    pub const json_field_names = .{
        .artifact_store = "artifactStore",
        .artifact_stores = "artifactStores",
        .execution_mode = "executionMode",
        .name = "name",
        .pipeline_type = "pipelineType",
        .role_arn = "roleArn",
        .stages = "stages",
        .triggers = "triggers",
        .variables = "variables",
        .version = "version",
    };
};
