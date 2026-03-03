const NetworkInfo = @import("network_info.zig").NetworkInfo;
const OSInfo = @import("os_info.zig").OSInfo;

/// Information about the server that hosts application components.
pub const SystemInfo = struct {
    /// CPU architecture type for the server.
    cpu_architecture: ?[]const u8 = null,

    /// File system type for the server.
    file_system_type: ?[]const u8 = null,

    /// Networking information related to a server.
    network_info_list: ?[]const NetworkInfo = null,

    /// Operating system corresponding to a server.
    os_info: ?OSInfo = null,

    pub const json_field_names = .{
        .cpu_architecture = "cpuArchitecture",
        .file_system_type = "fileSystemType",
        .network_info_list = "networkInfoList",
        .os_info = "osInfo",
    };
};
