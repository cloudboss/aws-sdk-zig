const Hive = @import("hive.zig").Hive;
const SparkSubmit = @import("spark_submit.zig").SparkSubmit;

/// The driver that the job runs on.
pub const JobDriver = union(enum) {
    /// The job driver parameters specified for Hive.
    hive: ?Hive,
    /// The job driver parameters specified for Spark.
    spark_submit: ?SparkSubmit,

    pub const json_field_names = .{
        .hive = "hive",
        .spark_submit = "sparkSubmit",
    };
};
