/// The job driver for job type.
pub const SparkSqlJobDriver = struct {
    /// The SQL file to be executed.
    entry_point: ?[]const u8 = null,

    /// The Spark parameters to be included in the Spark SQL command.
    spark_sql_parameters: ?[]const u8 = null,

    pub const json_field_names = .{
        .entry_point = "entryPoint",
        .spark_sql_parameters = "sparkSqlParameters",
    };
};
