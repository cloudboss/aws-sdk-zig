/// Command to be run on a particular operating system.
pub const PlatformCommand = struct {
    /// Command for Linux.
    linux: ?[]const u8,

    /// Command for Windows.
    windows: ?[]const u8,

    pub const json_field_names = .{
        .linux = "linux",
        .windows = "windows",
    };
};
