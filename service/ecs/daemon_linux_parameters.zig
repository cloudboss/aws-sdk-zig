const KernelCapabilities = @import("kernel_capabilities.zig").KernelCapabilities;
const Device = @import("device.zig").Device;
const Tmpfs = @import("tmpfs.zig").Tmpfs;

/// The Linux-specific options that are applied to the daemon container, such as
/// Linux kernel capabilities.
pub const DaemonLinuxParameters = struct {
    /// The Linux capabilities for the container that are added to or dropped from
    /// the default configuration provided by Docker.
    capabilities: ?KernelCapabilities = null,

    /// Any host devices to expose to the container.
    devices: ?[]const Device = null,

    /// Run an `init` process inside the container that forwards signals and reaps
    /// processes.
    init_process_enabled: ?bool = null,

    /// The container path, mount options, and size (in MiB) of the tmpfs mount.
    tmpfs: ?[]const Tmpfs = null,

    pub const json_field_names = .{
        .capabilities = "capabilities",
        .devices = "devices",
        .init_process_enabled = "initProcessEnabled",
        .tmpfs = "tmpfs",
    };
};
