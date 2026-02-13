/// The parameters for a `LAMBDA` task type.
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
/// For Lambda tasks, Systems Manager ignores any values specified for
/// TaskParameters and
/// LoggingInfo.
pub const MaintenanceWindowLambdaParameters = struct {
    /// Pass client-specific information to the Lambda function that you are
    /// invoking. You can then process the client information in your Lambda
    /// function as you
    /// choose through the context variable.
    client_context: ?[]const u8,

    /// JSON to provide to your Lambda function as input.
    payload: ?[]const u8,

    /// (Optional) Specify an Lambda function version or alias name. If you specify
    /// a
    /// function version, the operation uses the qualified function Amazon Resource
    /// Name (ARN) to invoke
    /// a specific Lambda function. If you specify an alias name, the operation uses
    /// the
    /// alias ARN to invoke the Lambda function version to which the alias points.
    qualifier: ?[]const u8,

    pub const json_field_names = .{
        .client_context = "ClientContext",
        .payload = "Payload",
        .qualifier = "Qualifier",
    };
};
