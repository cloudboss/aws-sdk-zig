const ExportServerSideEncryption = @import("export_server_side_encryption.zig").ExportServerSideEncryption;
const RevisionDestinationEntry = @import("revision_destination_entry.zig").RevisionDestinationEntry;

/// Details of the operation to be performed by the job.
pub const ExportRevisionsToS3RequestDetails = struct {
    /// The unique identifier for the data set associated with this export job.
    data_set_id: []const u8,

    /// Encryption configuration for the export job.
    encryption: ?ExportServerSideEncryption,

    /// The destination for the revision.
    revision_destinations: []const RevisionDestinationEntry,

    pub const json_field_names = .{
        .data_set_id = "DataSetId",
        .encryption = "Encryption",
        .revision_destinations = "RevisionDestinations",
    };
};
