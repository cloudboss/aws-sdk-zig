const AssetDestinationEntry = @import("asset_destination_entry.zig").AssetDestinationEntry;
const ExportServerSideEncryption = @import("export_server_side_encryption.zig").ExportServerSideEncryption;

/// Details about the export to Amazon S3 response.
pub const ExportAssetsToS3ResponseDetails = struct {
    /// The destination in Amazon S3 where the asset is exported.
    asset_destinations: []const AssetDestinationEntry,

    /// The unique identifier for the data set associated with this export job.
    data_set_id: []const u8,

    /// Encryption configuration of the export job.
    encryption: ?ExportServerSideEncryption,

    /// The unique identifier for the revision associated with this export response.
    revision_id: []const u8,

    pub const json_field_names = .{
        .asset_destinations = "AssetDestinations",
        .data_set_id = "DataSetId",
        .encryption = "Encryption",
        .revision_id = "RevisionId",
    };
};
