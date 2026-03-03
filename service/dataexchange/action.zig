const AutoExportRevisionToS3RequestDetails = @import("auto_export_revision_to_s3_request_details.zig").AutoExportRevisionToS3RequestDetails;

/// What occurs after a certain event.
pub const Action = struct {
    /// Details for the export revision to Amazon S3 action.
    export_revision_to_s3: ?AutoExportRevisionToS3RequestDetails = null,

    pub const json_field_names = .{
        .export_revision_to_s3 = "ExportRevisionToS3",
    };
};
