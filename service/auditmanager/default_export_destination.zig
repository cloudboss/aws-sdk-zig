const ExportDestinationType = @import("export_destination_type.zig").ExportDestinationType;

/// The default s3 bucket where Audit Manager saves the files that you export
/// from evidence finder.
pub const DefaultExportDestination = struct {
    /// The destination bucket where Audit Manager stores exported files.
    destination: ?[]const u8,

    /// The destination type, such as Amazon S3.
    destination_type: ?ExportDestinationType,

    pub const json_field_names = .{
        .destination = "destination",
        .destination_type = "destinationType",
    };
};
