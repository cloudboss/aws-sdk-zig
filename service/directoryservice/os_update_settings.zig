const OSVersion = @import("os_version.zig").OSVersion;

/// OS version that the directory needs to be updated to.
pub const OSUpdateSettings = struct {
    /// OS version that the directory needs to be updated to.
    os_version: ?OSVersion,

    pub const json_field_names = .{
        .os_version = "OSVersion",
    };
};
