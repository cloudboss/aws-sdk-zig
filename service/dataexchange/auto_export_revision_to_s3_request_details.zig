const ExportServerSideEncryption = @import("export_server_side_encryption.zig").ExportServerSideEncryption;
const AutoExportRevisionDestinationEntry = @import("auto_export_revision_destination_entry.zig").AutoExportRevisionDestinationEntry;

/// Details of the operation to be performed by the job.
pub const AutoExportRevisionToS3RequestDetails = struct {
    /// Encryption configuration for the auto export job.
    encryption: ?ExportServerSideEncryption,

    /// A revision destination is the Amazon S3 bucket folder destination to where
    /// the export
    /// will be sent.
    revision_destination: AutoExportRevisionDestinationEntry,

    pub const json_field_names = .{
        .encryption = "Encryption",
        .revision_destination = "RevisionDestination",
    };
};
