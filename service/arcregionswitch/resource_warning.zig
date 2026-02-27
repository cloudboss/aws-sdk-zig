const ResourceWarningStatus = @import("resource_warning_status.zig").ResourceWarningStatus;
const MinimalWorkflow = @import("minimal_workflow.zig").MinimalWorkflow;

/// Represents a warning about a resource in a Region switch plan.
pub const ResourceWarning = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: ?[]const u8,

    /// The name of the step for the resource warning.
    step_name: ?[]const u8,

    /// The version for the resource warning.
    version: []const u8,

    /// The warning message about what needs to be corrected.
    warning_message: []const u8,

    /// The status of the resource warning.
    warning_status: ResourceWarningStatus,

    /// The timestamp when the warning was last updated.
    warning_updated_time: i64,

    /// The workflow for the resource warning.
    workflow: ?MinimalWorkflow,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .step_name = "stepName",
        .version = "version",
        .warning_message = "warningMessage",
        .warning_status = "warningStatus",
        .warning_updated_time = "warningUpdatedTime",
        .workflow = "workflow",
    };
};
