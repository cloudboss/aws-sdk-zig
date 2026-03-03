const SparkSqlJobDriver = @import("spark_sql_job_driver.zig").SparkSqlJobDriver;
const SparkSubmitJobDriver = @import("spark_submit_job_driver.zig").SparkSubmitJobDriver;

/// Specify the driver that the job runs on. Exactly one of the two available
/// job drivers is
/// required, either sparkSqlJobDriver or sparkSubmitJobDriver.
pub const JobDriver = struct {
    /// The job driver for job type.
    spark_sql_job_driver: ?SparkSqlJobDriver = null,

    /// The job driver parameters specified for spark submit.
    spark_submit_job_driver: ?SparkSubmitJobDriver = null,

    pub const json_field_names = .{
        .spark_sql_job_driver = "sparkSqlJobDriver",
        .spark_submit_job_driver = "sparkSubmitJobDriver",
    };
};
