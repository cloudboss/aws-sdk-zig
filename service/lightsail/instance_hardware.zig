const Disk = @import("disk.zig").Disk;

/// Describes the hardware for the instance.
pub const InstanceHardware = struct {
    /// The number of vCPUs the instance has.
    cpu_count: ?i32,

    /// The disks attached to the instance.
    disks: ?[]const Disk,

    /// The amount of RAM in GB on the instance (`1.0`).
    ram_size_in_gb: ?f32,

    pub const json_field_names = .{
        .cpu_count = "cpuCount",
        .disks = "disks",
        .ram_size_in_gb = "ramSizeInGb",
    };
};
