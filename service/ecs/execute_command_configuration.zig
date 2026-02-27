const ExecuteCommandLogConfiguration = @import("execute_command_log_configuration.zig").ExecuteCommandLogConfiguration;
const ExecuteCommandLogging = @import("execute_command_logging.zig").ExecuteCommandLogging;

/// The details of the execute command configuration.
pub const ExecuteCommandConfiguration = struct {
    /// Specify an Key
    /// Management Service key ID to encrypt the data between the local client and
    /// the container.
    kms_key_id: ?[]const u8,

    /// The log configuration for the results of the execute command actions. The
    /// logs can be
    /// sent to CloudWatch Logs or an Amazon S3 bucket. When `logging=OVERRIDE` is
    /// specified, a `logConfiguration` must be provided.
    log_configuration: ?ExecuteCommandLogConfiguration,

    /// The log setting to use for redirecting logs for your execute command
    /// results. The
    /// following log settings are available.
    ///
    /// * `NONE`: The execute command session is not logged.
    ///
    /// * `DEFAULT`: The `awslogs` configuration in the task
    /// definition is used. If no logging parameter is specified, it defaults to
    /// this
    /// value. If no `awslogs` log driver is configured in the task
    /// definition, the output won't be logged.
    ///
    /// * `OVERRIDE`: Specify the logging details as a part of
    /// `logConfiguration`. If the `OVERRIDE` logging option
    /// is specified, the `logConfiguration` is required.
    logging: ?ExecuteCommandLogging,

    pub const json_field_names = .{
        .kms_key_id = "kmsKeyId",
        .log_configuration = "logConfiguration",
        .logging = "logging",
    };
};
