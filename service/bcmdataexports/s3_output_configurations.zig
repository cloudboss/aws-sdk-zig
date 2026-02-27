const CompressionOption = @import("compression_option.zig").CompressionOption;
const FormatOption = @import("format_option.zig").FormatOption;
const S3OutputType = @import("s3_output_type.zig").S3OutputType;
const OverwriteOption = @import("overwrite_option.zig").OverwriteOption;

/// The compression type, file format, and overwrite preference for the data
/// export.
pub const S3OutputConfigurations = struct {
    /// The compression type for the data export.
    compression: CompressionOption,

    /// The file format for the data export.
    format: FormatOption,

    /// The output type for the data export.
    output_type: S3OutputType,

    /// The rule to follow when generating a version of the data export file. You
    /// have the choice
    /// to overwrite the previous version or to be delivered in addition to the
    /// previous versions.
    /// Overwriting exports can save on Amazon S3 storage costs. Creating new export
    /// versions allows
    /// you to track the changes in cost and usage data over time.
    overwrite: OverwriteOption,

    pub const json_field_names = .{
        .compression = "Compression",
        .format = "Format",
        .output_type = "OutputType",
        .overwrite = "Overwrite",
    };
};
