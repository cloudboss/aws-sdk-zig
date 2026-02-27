const VolumeFilterName = @import("volume_filter_name.zig").VolumeFilterName;

/// A filter used to restrict the results of describe calls for Amazon FSx for
/// NetApp ONTAP or Amazon FSx for OpenZFS volumes. You can use multiple filters
/// to
/// return results that meet all applied filter requirements.
pub const VolumeFilter = struct {
    /// The name for this filter.
    name: ?VolumeFilterName,

    /// The values of the filter. These are all the values for any of the applied
    /// filters.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
