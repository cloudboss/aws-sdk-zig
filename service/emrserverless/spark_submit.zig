/// The configurations for the Spark submit job driver.
pub const SparkSubmit = struct {
    /// The entry point for the Spark submit job run.
    entry_point: []const u8,

    /// The arguments for the Spark submit job run.
    entry_point_arguments: ?[]const []const u8,

    /// The parameters for the Spark submit job run.
    spark_submit_parameters: ?[]const u8,

    pub const json_field_names = .{
        .entry_point = "entryPoint",
        .entry_point_arguments = "entryPointArguments",
        .spark_submit_parameters = "sparkSubmitParameters",
    };
};
