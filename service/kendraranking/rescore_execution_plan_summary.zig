const RescoreExecutionPlanStatus = @import("rescore_execution_plan_status.zig").RescoreExecutionPlanStatus;

/// Summary information for a rescore execution plan. A rescore
/// execution plan is an Amazon Kendra Intelligent Ranking
/// resource used for provisioning the `Rescore` API.
pub const RescoreExecutionPlanSummary = struct {
    /// The Unix timestamp when the rescore execution plan
    /// was created.
    created_at: ?i64 = null,

    /// The identifier of the rescore execution plan.
    id: ?[]const u8 = null,

    /// The name of the rescore execution plan.
    name: ?[]const u8 = null,

    /// The current status of the rescore execution plan. When
    /// the value is `ACTIVE`, the rescore execution
    /// plan is ready for use.
    status: ?RescoreExecutionPlanStatus = null,

    /// The Unix timestamp when the rescore execution plan
    /// was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .id = "Id",
        .name = "Name",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
