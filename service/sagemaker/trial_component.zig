const aws = @import("aws");

const UserContext = @import("user_context.zig").UserContext;
const TrialComponentArtifact = @import("trial_component_artifact.zig").TrialComponentArtifact;
const MetadataProperties = @import("metadata_properties.zig").MetadataProperties;
const TrialComponentMetricSummary = @import("trial_component_metric_summary.zig").TrialComponentMetricSummary;
const TrialComponentParameterValue = @import("trial_component_parameter_value.zig").TrialComponentParameterValue;
const Parent = @import("parent.zig").Parent;
const TrialComponentSource = @import("trial_component_source.zig").TrialComponentSource;
const TrialComponentSourceDetail = @import("trial_component_source_detail.zig").TrialComponentSourceDetail;
const TrialComponentStatus = @import("trial_component_status.zig").TrialComponentStatus;
const Tag = @import("tag.zig").Tag;

/// The properties of a trial component as returned by the
/// [Search](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Search.html) API.
pub const TrialComponent = struct {
    /// Who created the trial component.
    created_by: ?UserContext,

    /// When the component was created.
    creation_time: ?i64,

    /// The name of the component as displayed. If `DisplayName` isn't specified,
    /// `TrialComponentName` is displayed.
    display_name: ?[]const u8,

    /// When the component ended.
    end_time: ?i64,

    /// The input artifacts of the component.
    input_artifacts: ?[]const aws.map.MapEntry(TrialComponentArtifact),

    last_modified_by: ?UserContext,

    /// When the component was last modified.
    last_modified_time: ?i64,

    /// The Amazon Resource Name (ARN) of the lineage group resource.
    lineage_group_arn: ?[]const u8,

    metadata_properties: ?MetadataProperties,

    /// The metrics for the component.
    metrics: ?[]const TrialComponentMetricSummary,

    /// The output artifacts of the component.
    output_artifacts: ?[]const aws.map.MapEntry(TrialComponentArtifact),

    /// The hyperparameters of the component.
    parameters: ?[]const aws.map.MapEntry(TrialComponentParameterValue),

    /// An array of the parents of the component. A parent is a trial the component
    /// is associated with and the experiment the trial is part of. A component
    /// might not have any parents.
    parents: ?[]const Parent,

    /// The name of the experiment run.
    run_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) and job type of the source of the component.
    source: ?TrialComponentSource,

    /// Details of the source of the component.
    source_detail: ?TrialComponentSourceDetail,

    /// When the component started.
    start_time: ?i64,

    status: ?TrialComponentStatus,

    /// The list of tags that are associated with the component. You can use
    /// [Search](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Search.html) API to search on the tags.
    tags: ?[]const Tag,

    /// The Amazon Resource Name (ARN) of the trial component.
    trial_component_arn: ?[]const u8,

    /// The name of the trial component.
    trial_component_name: ?[]const u8,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .display_name = "DisplayName",
        .end_time = "EndTime",
        .input_artifacts = "InputArtifacts",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .lineage_group_arn = "LineageGroupArn",
        .metadata_properties = "MetadataProperties",
        .metrics = "Metrics",
        .output_artifacts = "OutputArtifacts",
        .parameters = "Parameters",
        .parents = "Parents",
        .run_name = "RunName",
        .source = "Source",
        .source_detail = "SourceDetail",
        .start_time = "StartTime",
        .status = "Status",
        .tags = "Tags",
        .trial_component_arn = "TrialComponentArn",
        .trial_component_name = "TrialComponentName",
    };
};
