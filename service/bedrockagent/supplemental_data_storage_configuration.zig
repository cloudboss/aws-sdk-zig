const SupplementalDataStorageLocation = @import("supplemental_data_storage_location.zig").SupplementalDataStorageLocation;

/// Specifies configurations for the storage location of multimedia content
/// (images, audio, and video) extracted from multimodal documents in your data
/// source. This content can be retrieved and returned to the end user with
/// timestamp references for audio and video segments.
pub const SupplementalDataStorageConfiguration = struct {
    /// A list of objects specifying storage locations for multimedia content
    /// (images, audio, and video) extracted from multimodal documents in your data
    /// source.
    storage_locations: []const SupplementalDataStorageLocation,

    pub const json_field_names = .{
        .storage_locations = "storageLocations",
    };
};
