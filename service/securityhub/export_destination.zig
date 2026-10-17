const S3ExportDestination = @import("s3_export_destination.zig").S3ExportDestination;

/// Specifies where Security Hub writes the export output. This is a union: you
/// must specify exactly one member. Currently, the only supported member is
/// `S3`.
pub const ExportDestination = union(enum) {
    /// The Amazon Simple Storage Service (Amazon S3) bucket and Amazon Web Services
    /// Key Management Service (Amazon Web Services KMS) key that Security Hub uses
    /// to write the export.
    s3: ?S3ExportDestination,

    pub const json_field_names = .{
        .s3 = "S3",
    };
};
