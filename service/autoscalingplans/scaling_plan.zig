const ApplicationSource = @import("application_source.zig").ApplicationSource;
const ScalingInstruction = @import("scaling_instruction.zig").ScalingInstruction;
const ScalingPlanStatusCode = @import("scaling_plan_status_code.zig").ScalingPlanStatusCode;

/// Represents a scaling plan.
pub const ScalingPlan = struct {
    /// A CloudFormation stack or a set of tags. You can create one scaling plan per
    /// application
    /// source.
    application_source: ApplicationSource,

    /// The Unix time stamp when the scaling plan was created.
    creation_time: ?i64 = null,

    /// The scaling instructions.
    scaling_instructions: []const ScalingInstruction,

    /// The name of the scaling plan.
    scaling_plan_name: []const u8,

    /// The version number of the scaling plan.
    scaling_plan_version: i64,

    /// The status of the scaling plan.
    ///
    /// * `Active` - The scaling plan is active.
    ///
    /// * `ActiveWithProblems` - The scaling plan is active, but the scaling
    /// configuration for one or more resources could not be applied.
    ///
    /// * `CreationInProgress` - The scaling plan is being created.
    ///
    /// * `CreationFailed` - The scaling plan could not be created.
    ///
    /// * `DeletionInProgress` - The scaling plan is being deleted.
    ///
    /// * `DeletionFailed` - The scaling plan could not be deleted.
    ///
    /// * `UpdateInProgress` - The scaling plan is being updated.
    ///
    /// * `UpdateFailed` - The scaling plan could not be updated.
    status_code: ScalingPlanStatusCode,

    /// A simple message about the current status of the scaling plan.
    status_message: ?[]const u8 = null,

    /// The Unix time stamp when the scaling plan entered the current status.
    status_start_time: ?i64 = null,

    pub const json_field_names = .{
        .application_source = "ApplicationSource",
        .creation_time = "CreationTime",
        .scaling_instructions = "ScalingInstructions",
        .scaling_plan_name = "ScalingPlanName",
        .scaling_plan_version = "ScalingPlanVersion",
        .status_code = "StatusCode",
        .status_message = "StatusMessage",
        .status_start_time = "StatusStartTime",
    };
};
