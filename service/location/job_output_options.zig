const JobOutputFormat = @import("job_output_format.zig").JobOutputFormat;

/// Configuration for output data location and format.
pub const JobOutputOptions = struct {
    /// Output data format. Currently only "Parquet" is supported.
    format: JobOutputFormat,

    /// S3 ARN or URI where output files will be written.
    ///
    /// The Amazon S3 bucket must exist in the same Amazon Web Services region where
    /// you plan to run your job.
    location: []const u8,

    pub const json_field_names = .{
        .format = "Format",
        .location = "Location",
    };
};
