const CPU = @import("cpu.zig").CPU;
const Disk = @import("disk.zig").Disk;
const IdentificationHints = @import("identification_hints.zig").IdentificationHints;
const NetworkInterface = @import("network_interface.zig").NetworkInterface;
const OS = @import("os.zig").OS;

/// Properties of the Source Server machine.
pub const SourceProperties = struct {
    /// An array of CPUs.
    cpus: ?[]const CPU,

    /// An array of disks.
    disks: ?[]const Disk,

    /// Hints used to uniquely identify a machine.
    identification_hints: ?IdentificationHints,

    /// The date and time the Source Properties were last updated on.
    last_updated_date_time: ?[]const u8,

    /// An array of network interfaces.
    network_interfaces: ?[]const NetworkInterface,

    /// Operating system.
    os: ?OS,

    /// The amount of RAM in bytes.
    ram_bytes: i64 = 0,

    /// The recommended EC2 instance type that will be used when recovering the
    /// Source Server.
    recommended_instance_type: ?[]const u8,

    /// Are EC2 nitro instance types supported when recovering the Source Server.
    supports_nitro_instances: ?bool,

    pub const json_field_names = .{
        .cpus = "cpus",
        .disks = "disks",
        .identification_hints = "identificationHints",
        .last_updated_date_time = "lastUpdatedDateTime",
        .network_interfaces = "networkInterfaces",
        .os = "os",
        .ram_bytes = "ramBytes",
        .recommended_instance_type = "recommendedInstanceType",
        .supports_nitro_instances = "supportsNitroInstances",
    };
};
