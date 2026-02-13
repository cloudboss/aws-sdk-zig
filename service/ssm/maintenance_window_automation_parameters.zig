const aws = @import("aws");

/// The parameters for an `AUTOMATION` task type.
pub const MaintenanceWindowAutomationParameters = struct {
    /// The version of an Automation runbook to use during task execution.
    document_version: ?[]const u8,

    /// The parameters for the `AUTOMATION` task.
    ///
    /// For information about specifying and updating task parameters, see
    /// RegisterTaskWithMaintenanceWindow and UpdateMaintenanceWindowTask.
    ///
    /// **Note:**
    ///
    /// `LoggingInfo` has been deprecated. To specify an Amazon Simple Storage
    /// Service (Amazon S3) bucket to contain logs, instead use the
    /// `OutputS3BucketName` and `OutputS3KeyPrefix` options in the
    /// `TaskInvocationParameters` structure.
    /// For information about how Amazon Web Services Systems Manager handles these
    /// options for the supported maintenance
    /// window task types, see MaintenanceWindowTaskInvocationParameters.
    ///
    /// `TaskParameters` has been deprecated. To specify parameters to pass to a
    /// task when it runs,
    /// instead use the `Parameters` option in the `TaskInvocationParameters`
    /// structure. For information
    /// about how Systems Manager handles these options for the supported
    /// maintenance window task
    /// types, see MaintenanceWindowTaskInvocationParameters.
    ///
    /// For `AUTOMATION` task types, Amazon Web Services Systems Manager ignores any
    /// values specified for these
    /// parameters.
    parameters: ?[]const aws.map.MapEntry([]const []const u8),

    pub const json_field_names = .{
        .document_version = "DocumentVersion",
        .parameters = "Parameters",
    };
};
