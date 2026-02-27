const S3ExportSpecification = @import("s3_export_specification.zig").S3ExportSpecification;

/// This contains the export specification object.
pub const ExportSpecification = union(enum) {
    /// This specifies the destination Amazon S3 bucket for the export job. And, if
    /// included, it also specifies the destination prefix.
    s_3_export_specification: ?S3ExportSpecification,

    pub const json_field_names = .{
        .s_3_export_specification = "s3ExportSpecification",
    };
};
