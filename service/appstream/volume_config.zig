/// Configuration for the root volume of fleet instances and image builders.
/// This allows you to customize the storage capacity beyond the default 200 GB.
pub const VolumeConfig = struct {
    /// The size of the root volume in GB. Valid range is 200-500 GB. The default is
    /// 200 GB, which is included in the hourly instance rate. Additional storage
    /// beyond 200 GB incurs extra charges and applies to instances regardless of
    /// their running state.
    volume_size_in_gb: ?i32 = null,

    pub const json_field_names = .{
        .volume_size_in_gb = "VolumeSizeInGb",
    };
};
