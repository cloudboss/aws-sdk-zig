const CPU = @import("cpu.zig").CPU;
const Disk = @import("disk.zig").Disk;
const IdentificationHints = @import("identification_hints.zig").IdentificationHints;
const NetworkInterface = @import("network_interface.zig").NetworkInterface;
const OS = @import("os.zig").OS;

/// Source server properties.
pub const SourceProperties = struct {
    /// Source Server CPUs.
    cpus: ?[]const CPU,

    /// Source Server disks.
    disks: ?[]const Disk,

    /// Source server identification hints.
    identification_hints: ?IdentificationHints,

    /// Source server last update date and time.
    last_updated_date_time: ?[]const u8,

    /// Source server network interfaces.
    network_interfaces: ?[]const NetworkInterface,

    /// Source server OS.
    os: ?OS,

    /// Source server RAM in bytes.
    ram_bytes: i64 = 0,

    /// Source server recommended instance type.
    recommended_instance_type: ?[]const u8,

    pub const json_field_names = .{
        .cpus = "cpus",
        .disks = "disks",
        .identification_hints = "identificationHints",
        .last_updated_date_time = "lastUpdatedDateTime",
        .network_interfaces = "networkInterfaces",
        .os = "os",
        .ram_bytes = "ramBytes",
        .recommended_instance_type = "recommendedInstanceType",
    };
};
