const S3ExportDestinationConfiguration = @import("s3_export_destination_configuration.zig").S3ExportDestinationConfiguration;

/// The destination configuration for delivering exported email data.
pub const ExportDestinationConfiguration = union(enum) {
    /// Configuration for delivering to an Amazon S3 bucket.
    s3: ?S3ExportDestinationConfiguration,

    pub const json_field_names = .{
        .s3 = "S3",
    };
};
