const aws = @import("aws");

const TargetPreview = @import("target_preview.zig").TargetPreview;

/// Information about the results of the execution preview.
pub const AutomationExecutionPreview = struct {
    /// Information about the Amazon Web Services Regions targeted by the execution
    /// preview.
    regions: ?[]const []const u8,

    /// Information about the type of impact a runbook step would have on a
    /// resource.
    ///
    /// * `Mutating`: The runbook step would make changes to the targets through
    ///   actions
    /// that create, modify, or delete resources.
    ///
    /// * `Non_Mutating`: The runbook step would retrieve data about resources but
    ///   not
    /// make changes to them. This category generally includes `Describe*`,
    /// `List*`, `Get*`, and similar read-only API actions.
    ///
    /// * `Undetermined`: An undetermined step invokes executions performed by
    ///   another
    /// orchestration service like Lambda, Step Functions, or Amazon Web Services
    /// Systems Manager Run Command. An undetermined step might also call a
    /// third-party API. Systems Manager Automation doesn't know the outcome of the
    /// orchestration processes or
    /// third-party API executions, so the results of the steps are undetermined.
    step_previews: ?[]const aws.map.MapEntry(i32),

    /// Information that provides a preview of what the impact of running the
    /// specified Automation
    /// runbook would be.
    target_previews: ?[]const TargetPreview,

    /// Information about the Amazon Web Services accounts that were included in the
    /// execution
    /// preview.
    total_accounts: ?i32,

    pub const json_field_names = .{
        .regions = "Regions",
        .step_previews = "StepPreviews",
        .target_previews = "TargetPreviews",
        .total_accounts = "TotalAccounts",
    };
};
