const S3Location = @import("s3_location.zig").S3Location;
const SupplementalDataStorageLocationType = @import("supplemental_data_storage_location_type.zig").SupplementalDataStorageLocationType;

/// Contains information about a storage location for images extracted from
/// multimodal documents in your data source.
pub const SupplementalDataStorageLocation = struct {
    /// Contains information about the Amazon S3 location for the extracted images.
    s_3_location: ?S3Location = null,

    /// Specifies the storage service used for this location.
    @"type": SupplementalDataStorageLocationType,

    pub const json_field_names = .{
        .s_3_location = "s3Location",
        .@"type" = "type",
    };
};
