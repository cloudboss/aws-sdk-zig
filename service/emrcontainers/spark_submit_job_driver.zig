/// The information about job driver for Spark submit.
pub const SparkSubmitJobDriver = struct {
    /// The entry point of job application.
    entry_point: []const u8,

    /// The arguments for job application.
    entry_point_arguments: ?[]const []const u8 = null,

    /// The Spark submit parameters that are used for job runs.
    spark_submit_parameters: ?[]const u8 = null,

    pub const json_field_names = .{
        .entry_point = "entryPoint",
        .entry_point_arguments = "entryPointArguments",
        .spark_submit_parameters = "sparkSubmitParameters",
    };
};
