const BackupDetails = @import("backup_details.zig").BackupDetails;
const SourceTableDetails = @import("source_table_details.zig").SourceTableDetails;
const SourceTableFeatureDetails = @import("source_table_feature_details.zig").SourceTableFeatureDetails;

/// Contains the description of the backup created for the table.
pub const BackupDescription = struct {
    /// Contains the details of the backup created for the table.
    backup_details: ?BackupDetails,

    /// Contains the details of the table when the backup was created.
    source_table_details: ?SourceTableDetails,

    /// Contains the details of the features enabled on the table when the backup
    /// was created.
    /// For example, LSIs, GSIs, streams, TTL.
    source_table_feature_details: ?SourceTableFeatureDetails,
};
