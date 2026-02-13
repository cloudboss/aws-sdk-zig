/// The parameters for a `STEP_FUNCTIONS` task.
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
/// For Step Functions tasks, Systems Manager ignores any values specified for
/// `TaskParameters` and `LoggingInfo`.
pub const MaintenanceWindowStepFunctionsParameters = struct {
    /// The inputs for the `STEP_FUNCTIONS` task.
    input: ?[]const u8,

    /// The name of the `STEP_FUNCTIONS` task.
    name: ?[]const u8,

    pub const json_field_names = .{
        .input = "Input",
        .name = "Name",
    };
};
