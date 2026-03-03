const ValidVolumeOptions = @import("valid_volume_options.zig").ValidVolumeOptions;

/// Contains the valid options for additional storage volumes for a DB instance.
pub const ValidAdditionalStorageOptions = struct {
    /// Indicates whether the DB instance supports additional storage volumes.
    supports_additional_storage_volumes: ?bool = null,

    /// The valid additional storage volume options for the DB instance.
    volumes: ?[]const ValidVolumeOptions = null,
};
