const aws = @import("aws");

const ControlMappingSource = @import("control_mapping_source.zig").ControlMappingSource;
const ControlState = @import("control_state.zig").ControlState;
const ControlType = @import("control_type.zig").ControlType;

/// A control in Audit Manager.
pub const Control = struct {
    /// The recommended actions to carry out if the control isn't fulfilled.
    action_plan_instructions: ?[]const u8 = null,

    /// The title of the action plan for remediating the control.
    action_plan_title: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the control.
    arn: ?[]const u8 = null,

    /// The data mapping sources for the control.
    control_mapping_sources: ?[]const ControlMappingSource = null,

    /// The data source types that determine where Audit Manager collects evidence
    /// from for
    /// the control.
    control_sources: ?[]const u8 = null,

    /// The time when the control was created.
    created_at: ?i64 = null,

    /// The user or role that created the control.
    created_by: ?[]const u8 = null,

    /// The description of the control.
    description: ?[]const u8 = null,

    /// The unique identifier for the control.
    id: ?[]const u8 = null,

    /// The time when the control was most recently updated.
    last_updated_at: ?i64 = null,

    /// The user or role that most recently updated the control.
    last_updated_by: ?[]const u8 = null,

    /// The name of the control.
    name: ?[]const u8 = null,

    /// The state of the control. The `END_OF_SUPPORT` state is applicable to
    /// standard controls only. This state indicates that the standard control can
    /// still be used to
    /// collect evidence, but Audit Manager is no longer updating or maintaining
    /// that
    /// control.
    state: ?ControlState = null,

    /// The tags associated with the control.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The steps that you should follow to determine if the control has been
    /// satisfied.
    testing_information: ?[]const u8 = null,

    /// Specifies whether the control is a standard control or a custom control.
    @"type": ?ControlType = null,

    pub const json_field_names = .{
        .action_plan_instructions = "actionPlanInstructions",
        .action_plan_title = "actionPlanTitle",
        .arn = "arn",
        .control_mapping_sources = "controlMappingSources",
        .control_sources = "controlSources",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .last_updated_by = "lastUpdatedBy",
        .name = "name",
        .state = "state",
        .tags = "tags",
        .testing_information = "testingInformation",
        .@"type" = "type",
    };
};
