const ExportServerSideEncryption = @import("export_server_side_encryption.zig").ExportServerSideEncryption;
const RevisionDestinationEntry = @import("revision_destination_entry.zig").RevisionDestinationEntry;

/// Details about the export revisions to Amazon S3 response.
pub const ExportRevisionsToS3ResponseDetails = struct {
    /// The unique identifier for the data set associated with this export job.
    data_set_id: []const u8,

    /// Encryption configuration of the export job.
    encryption: ?ExportServerSideEncryption = null,

    /// The Amazon Resource Name (ARN) of the event action.
    event_action_arn: ?[]const u8 = null,

    /// The destination in Amazon S3 where the revision is exported.
    revision_destinations: []const RevisionDestinationEntry,

    pub const json_field_names = .{
        .data_set_id = "DataSetId",
        .encryption = "Encryption",
        .event_action_arn = "EventActionArn",
        .revision_destinations = "RevisionDestinations",
    };
};
