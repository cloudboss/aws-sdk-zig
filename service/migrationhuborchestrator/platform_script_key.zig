/// The script location for a particular operating system.
pub const PlatformScriptKey = struct {
    /// The script location for Linux.
    linux: ?[]const u8,

    /// The script location for Windows.
    windows: ?[]const u8,

    pub const json_field_names = .{
        .linux = "linux",
        .windows = "windows",
    };
};
