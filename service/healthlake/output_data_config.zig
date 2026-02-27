const S3Configuration = @import("s3_configuration.zig").S3Configuration;

/// The output data configuration supplied when the export job was created.
pub const OutputDataConfig = union(enum) {
    /// The output data configuration supplied when the export job was created.
    s3_configuration: ?S3Configuration,

    pub const json_field_names = .{
        .s3_configuration = "S3Configuration",
    };
};
