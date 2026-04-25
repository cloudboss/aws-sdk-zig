const HostVolumeProperties = @import("host_volume_properties.zig").HostVolumeProperties;

/// A data volume definition for a daemon task.
pub const DaemonVolume = struct {
    /// The contents of the `host` parameter determine whether your bind mount host
    /// volume persists on the host container instance and where it's stored.
    host: ?HostVolumeProperties = null,

    /// The name of the volume. Up to 255 letters (uppercase and lowercase),
    /// numbers, underscores, and hyphens are allowed.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .host = "host",
        .name = "name",
    };
};
