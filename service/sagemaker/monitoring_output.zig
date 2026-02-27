const MonitoringS3Output = @import("monitoring_s3_output.zig").MonitoringS3Output;

/// The output object for a monitoring job.
pub const MonitoringOutput = struct {
    /// The Amazon S3 storage location where the results of a monitoring job are
    /// saved.
    s3_output: MonitoringS3Output,

    pub const json_field_names = .{
        .s3_output = "S3Output",
    };
};
