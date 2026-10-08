const StepName = @import("step_name.zig").StepName;
const StepStatus = @import("step_status.zig").StepStatus;

/// Represents a step in the pentest job execution pipeline. Steps include
/// preflight, static analysis, pentest, and finalizing.
pub const Step = struct {
    /// The date and time the step was created, in UTC format.
    created_at: ?i64 = null,

    /// The name of the step. Valid values include PREFLIGHT, STATIC_ANALYSIS,
    /// PENTEST, VALIDATION, and FINALIZING.
    name: ?StepName = null,

    /// The current status of the step.
    status: ?StepStatus = null,

    /// The date and time the step was last updated, in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .name = "name",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
