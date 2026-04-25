const JobInputFormat = @import("job_input_format.zig").JobInputFormat;

/// Configuration for input data location and format.
///
/// Input files have a limitation of 10gb per file, and 1gb per Parquet
/// row-group within the file.
pub const JobInputOptions = struct {
    /// Input data format. Currently only `Parquet` is supported.
    ///
    /// Input files have a limitation of 10gb per file, and 1gb per Parquet
    /// row-group within the file.
    format: JobInputFormat,

    /// S3 ARN or URI where input files are stored.
    ///
    /// The Amazon S3 bucket must be created in the same Amazon Web Services region
    /// where you plan to run your job.
    location: []const u8,

    pub const json_field_names = .{
        .format = "Format",
        .location = "Location",
    };
};
