const UserContext = @import("user_context.zig").UserContext;
const TrialComponentStatus = @import("trial_component_status.zig").TrialComponentStatus;
const TrialComponentSource = @import("trial_component_source.zig").TrialComponentSource;

/// A summary of the properties of a trial component. To get all the properties,
/// call the
/// [DescribeTrialComponent](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeTrialComponent.html) API and provide the `TrialComponentName`.
pub const TrialComponentSummary = struct {
    /// Who created the trial component.
    created_by: ?UserContext,

    /// When the component was created.
    creation_time: ?i64,

    /// The name of the component as displayed. If `DisplayName` isn't specified,
    /// `TrialComponentName` is displayed.
    display_name: ?[]const u8,

    /// When the component ended.
    end_time: ?i64,

    /// Who last modified the component.
    last_modified_by: ?UserContext,

    /// When the component was last modified.
    last_modified_time: ?i64,

    /// When the component started.
    start_time: ?i64,

    /// The status of the component. States include:
    ///
    /// * InProgress
    /// * Completed
    /// * Failed
    status: ?TrialComponentStatus,

    /// The Amazon Resource Name (ARN) of the trial component.
    trial_component_arn: ?[]const u8,

    /// The name of the trial component.
    trial_component_name: ?[]const u8,

    trial_component_source: ?TrialComponentSource,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .display_name = "DisplayName",
        .end_time = "EndTime",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .start_time = "StartTime",
        .status = "Status",
        .trial_component_arn = "TrialComponentArn",
        .trial_component_name = "TrialComponentName",
        .trial_component_source = "TrialComponentSource",
    };
};
