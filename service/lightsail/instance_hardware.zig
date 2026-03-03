const Disk = @import("disk.zig").Disk;

/// Describes the hardware for the instance.
pub const InstanceHardware = struct {
    /// The number of vCPUs the instance has.
    cpu_count: ?i32 = null,

    /// The disks attached to the instance.
    disks: ?[]const Disk = null,

    /// The amount of RAM in GB on the instance (`1.0`).
    ram_size_in_gb: ?f32 = null,

    pub const json_field_names = .{
        .cpu_count = "cpuCount",
        .disks = "disks",
        .ram_size_in_gb = "ramSizeInGb",
    };
};
