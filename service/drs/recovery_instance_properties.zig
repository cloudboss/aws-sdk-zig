const CPU = @import("cpu.zig").CPU;
const RecoveryInstanceDisk = @import("recovery_instance_disk.zig").RecoveryInstanceDisk;
const IdentificationHints = @import("identification_hints.zig").IdentificationHints;
const NetworkInterface = @import("network_interface.zig").NetworkInterface;
const OS = @import("os.zig").OS;

/// Properties of the Recovery Instance machine.
pub const RecoveryInstanceProperties = struct {
    /// An array of CPUs.
    cpus: ?[]const CPU = null,

    /// An array of disks.
    disks: ?[]const RecoveryInstanceDisk = null,

    /// Hints used to uniquely identify a machine.
    identification_hints: ?IdentificationHints = null,

    /// The date and time the Recovery Instance properties were last updated on.
    last_updated_date_time: ?[]const u8 = null,

    /// An array of network interfaces.
    network_interfaces: ?[]const NetworkInterface = null,

    /// Operating system.
    os: ?OS = null,

    /// The amount of RAM in bytes.
    ram_bytes: i64 = 0,

    pub const json_field_names = .{
        .cpus = "cpus",
        .disks = "disks",
        .identification_hints = "identificationHints",
        .last_updated_date_time = "lastUpdatedDateTime",
        .network_interfaces = "networkInterfaces",
        .os = "os",
        .ram_bytes = "ramBytes",
    };
};
