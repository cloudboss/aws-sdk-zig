/// The description of the worker configuration.
pub const WorkerConfigurationDescription = struct {
    /// The revision of the worker configuration.
    revision: i64 = 0,

    /// The Amazon Resource Name (ARN) of the worker configuration.
    worker_configuration_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .revision = "revision",
        .worker_configuration_arn = "workerConfigurationArn",
    };
};
