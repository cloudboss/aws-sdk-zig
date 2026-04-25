const HostPath = @import("host_path.zig").HostPath;

/// Volume used by the Kubernetes workload.
pub const Volume = struct {
    /// Represents a pre-existing file or directory on the host machine that the
    /// volume maps to.
    host_path: ?HostPath = null,

    /// Volume name.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .host_path = "HostPath",
        .name = "Name",
    };
};
