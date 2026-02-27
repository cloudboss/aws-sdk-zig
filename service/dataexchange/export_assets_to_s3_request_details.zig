const AssetDestinationEntry = @import("asset_destination_entry.zig").AssetDestinationEntry;
const ExportServerSideEncryption = @import("export_server_side_encryption.zig").ExportServerSideEncryption;

/// Details of the operation to be performed by the job.
pub const ExportAssetsToS3RequestDetails = struct {
    /// The destination for the asset.
    asset_destinations: []const AssetDestinationEntry,

    /// The unique identifier for the data set associated with this export job.
    data_set_id: []const u8,

    /// Encryption configuration for the export job.
    encryption: ?ExportServerSideEncryption,

    /// The unique identifier for the revision associated with this export request.
    revision_id: []const u8,

    pub const json_field_names = .{
        .asset_destinations = "AssetDestinations",
        .data_set_id = "DataSetId",
        .encryption = "Encryption",
        .revision_id = "RevisionId",
    };
};
