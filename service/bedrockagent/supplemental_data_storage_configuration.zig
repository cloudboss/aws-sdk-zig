const SupplementalDataStorageLocation = @import("supplemental_data_storage_location.zig").SupplementalDataStorageLocation;

/// Specifies configurations for the storage location of the images extracted
/// from multimodal documents in your data source. These images can be retrieved
/// and returned to the end user.
pub const SupplementalDataStorageConfiguration = struct {
    /// A list of objects specifying storage locations for images extracted from
    /// multimodal documents in your data source.
    storage_locations: []const SupplementalDataStorageLocation,

    pub const json_field_names = .{
        .storage_locations = "storageLocations",
    };
};
