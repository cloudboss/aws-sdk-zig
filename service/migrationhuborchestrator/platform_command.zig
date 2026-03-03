/// Command to be run on a particular operating system.
pub const PlatformCommand = struct {
    /// Command for Linux.
    linux: ?[]const u8 = null,

    /// Command for Windows.
    windows: ?[]const u8 = null,

    pub const json_field_names = .{
        .linux = "linux",
        .windows = "windows",
    };
};
