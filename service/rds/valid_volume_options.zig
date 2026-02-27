const ValidStorageOptions = @import("valid_storage_options.zig").ValidStorageOptions;

/// Contains the valid options for an additional storage volume.
pub const ValidVolumeOptions = struct {
    /// The valid storage options for the additional storage volume.
    storage: ?[]const ValidStorageOptions,

    /// The name of the additional storage volume.
    volume_name: ?[]const u8,
};
