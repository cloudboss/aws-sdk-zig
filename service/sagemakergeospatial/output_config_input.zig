const ExportS3DataInput = @import("export_s3_data_input.zig").ExportS3DataInput;

/// The response structure for an OutputConfig returned by an
/// ExportEarthObservationJob.
pub const OutputConfigInput = struct {
    /// Path to Amazon S3 storage location for the output configuration file.
    s3_data: ExportS3DataInput,

    pub const json_field_names = .{
        .s3_data = "S3Data",
    };
};
