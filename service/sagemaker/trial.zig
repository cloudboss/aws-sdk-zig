const UserContext = @import("user_context.zig").UserContext;
const MetadataProperties = @import("metadata_properties.zig").MetadataProperties;
const TrialSource = @import("trial_source.zig").TrialSource;
const Tag = @import("tag.zig").Tag;
const TrialComponentSimpleSummary = @import("trial_component_simple_summary.zig").TrialComponentSimpleSummary;

/// The properties of a trial as returned by the
/// [Search](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Search.html) API.
pub const Trial = struct {
    /// Who created the trial.
    created_by: ?UserContext,

    /// When the trial was created.
    creation_time: ?i64,

    /// The name of the trial as displayed. If `DisplayName` isn't specified,
    /// `TrialName` is displayed.
    display_name: ?[]const u8,

    /// The name of the experiment the trial is part of.
    experiment_name: ?[]const u8,

    last_modified_by: ?UserContext,

    /// Who last modified the trial.
    last_modified_time: ?i64,

    metadata_properties: ?MetadataProperties,

    source: ?TrialSource,

    /// The list of tags that are associated with the trial. You can use
    /// [Search](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Search.html) API to search on the tags.
    tags: ?[]const Tag,

    /// The Amazon Resource Name (ARN) of the trial.
    trial_arn: ?[]const u8,

    /// A list of the components associated with the trial. For each component, a
    /// summary of the component's properties is included.
    trial_component_summaries: ?[]const TrialComponentSimpleSummary,

    /// The name of the trial.
    trial_name: ?[]const u8,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .display_name = "DisplayName",
        .experiment_name = "ExperimentName",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .metadata_properties = "MetadataProperties",
        .source = "Source",
        .tags = "Tags",
        .trial_arn = "TrialArn",
        .trial_component_summaries = "TrialComponentSummaries",
        .trial_name = "TrialName",
    };
};
